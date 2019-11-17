//
//  AuthorizationEncyption.swift
//  GitSearch
//
//  Created by Vldmr on 11/17/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation
import CommonCrypto

class AuthorizationEncryption {
    
    static func base64UrlEncode(_ data: Data) -> String {
        var base64 = data.base64EncodedString()
        base64 = base64.replacingOccurrences(of: "=", with: "")
        base64 = base64.replacingOccurrences(of: "+", with: "-")
        base64 = base64.replacingOccurrences(of: "/", with: "_")
        return base64
    }
    
    static func generateRandomBytes() -> String? {
        var keyData = Data(count: 32)
        let count = keyData.count
        let result = keyData.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) -> Int32 in
            guard let pointerBaseAdress = pointer.bindMemory(to: UInt8.self).baseAddress else { return .min }
            return SecRandomCopyBytes(kSecRandomDefault, count, pointerBaseAdress)
        }
 
        if result == errSecSuccess {
            return base64UrlEncode(keyData)
        } else {
            // TODO: handle error
            return nil
        }
    }
    
    static func sha256(string: String) -> Data {
        let messageData = string.data(using: .utf8)!
        var digestData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes { digestBytes in
            messageData.withUnsafeBytes { messageBytes in
                guard let digestBytesBaseAdress = digestBytes.bindMemory(to: UInt8.self).baseAddress else { return }
                CC_SHA256(messageBytes.baseAddress, CC_LONG(messageData.count), digestBytesBaseAdress)
            }
        }

        return digestData
    }
}
