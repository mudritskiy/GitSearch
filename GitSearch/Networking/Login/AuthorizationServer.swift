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
            URLQueryItem(name: "code_challenge_method", value: "S256"),
            URLQueryItem(name: "code_challenge", value: challenge),
            URLQueryItem(name: "state", value: savedState),
            URLQueryItem(name: "scope", value: "id_token profile"),
//            URLQueryItem(name: "redirect_uri", value: "code"),
        ]
        
        sfSafariViewController = SFSafariViewController(url: urlComp.url!)
        viewController.present(sfSafariViewController!, animated: true, completion: nil)
        handler(true)
    
    }
    
    func getToken(handler: @escaping (Tokens?) -> Void) {
        
    }
    
    func reset() {
        codeVerifier = nil
        savedState = nil
        receivedCode = nil
        receivedState = nil
    }
    
}
