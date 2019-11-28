//
//  AuthorizationServer.swift
//  GitSearch
//
//  Created by Vldmr on 11/17/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class AuthorizationServer {
    
    private var codeVerifier: String? = nil
    private var savedState: String? = nil
    
    var receivedCode: String? = nil
    var receivedState: String? = nil
    
    private var sfSafariViewController: SFSafariViewController? = nil
    
    private func generateCodeChallenge() -> String? {
        codeVerifier = AuthorizationEncryption.generateRandomBytes()
        guard codeVerifier != nil else {
            return nil
        }
        return AuthorizationEncryption.base64UrlEncode(AuthorizationEncryption.sha256(string: codeVerifier!))
    }
    
    func authorize(viewController: UIViewController, handler:  @escaping (Bool) -> Void) {
        
        guard let challenge = generateCodeChallenge() else {
            // TODO: handle error
            handler(false)
            return
        }
        
        savedState = AuthorizationEncryption.generateRandomBytes()
        
        var urlComp = URLComponents(string: domain + "/authorize")!
        
        urlComp.queryItems = [
            URLQueryItem(name: "respone_type", value: "code"),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "redirect_uri", value: callbackUrl),
            URLQueryItem(name: "scope", value: "id_token profile"),
            URLQueryItem(name: "code_challenge_method", value: "S256"),
            URLQueryItem(name: "code_challenge", value: challenge),
            URLQueryItem(name: "state", value: savedState)
        ]
        
        sfSafariViewController = SFSafariViewController(url: urlComp.url!)
        viewController.present(sfSafariViewController!, animated: true, completion: nil)
        handler(true)
    
    }
    
    func parseAuthorizeRedirectUrl(url: URL) -> Bool {
        guard let urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            sfSafariViewController?.dismiss(animated: true, completion: nil)
            return false
        }
        
        if urlComp.queryItems == nil {
            sfSafariViewController?.dismiss(animated: true, completion: nil)
            return false
        }
        
        for item in urlComp.queryItems! {
            if item.name == "code" {
                receivedCode = item.value
            } else if item.name == "statde" {
                receivedState = item.value
            }
        }
        
        sfSafariViewController?.dismiss(animated: true, completion: nil)
        
        return receivedCode != nil && receivedState != nil
    }
    
    func getToken(handler: @escaping (Tokens?) -> Void) {
        if receivedCode == nil || codeVerifier == nil || savedState != receivedState {
            handler(nil)
            return
        }
        
        let urlComp = URLComponents(string: domain + "/oauth/token")!
        
        let body = [
            "grant_type": "authorization_code",
            "client_id": clientId,
            "code": receivedCode,
            "code_verifier": codeVerifier,
            "redirect_uri": callbackUrl
        ]
        
        var request = URLRequest(url: urlComp.url!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if (error != nil || data == nil) {
                // TODO: handle error
                handler(nil)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data!) as? [String: Any],
                let accessToken = json["access_token"] as? String
                else {
                    handler(nil)
                    return
            }
            
            handler(
                Tokens(accessToken: accessToken,
                       idToken: json["id_token"] as? String,
                       refreshToken: json["refresh_token"] as? String)
            )
            
        }
        
        task.resume()
    }
    
    func getProfile(accessToken: String, handler: @escaping (Profile?) -> Void) {
        let urlComp = URLComponents(string: domain + "/userinfo")!
        
        let urlSessionConfig = URLSessionConfiguration.default
        urlSessionConfig.httpAdditionalHeaders = [
            AnyHashable("Authorization"): "Bearer " + accessToken
        ]
        let urlSession = URLSession(configuration: urlSessionConfig)
        let task = urlSession.dataTask(with: urlComp.url!) {
            (data, response, error) in
            
            if (error != nil || data == nil) {
                // TODO: handle error
                handler(nil)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data!) as? [String: String] else {
                // TODO: handle error
                handler(nil)
                return
            }
            
            let result = Profile(name: json["name"], email: json["email"])
            handler(result)
        }
        
        task.resume()
    }
    
    func reset() {
        codeVerifier = nil
        savedState = nil
        receivedCode = nil
        receivedState = nil
    }
    
}
