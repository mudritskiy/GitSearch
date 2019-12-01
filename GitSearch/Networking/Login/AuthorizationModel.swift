//
//  AuthorizationModel.swift
//  GitSearch
//
//  Created by Vldmr on 11/17/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

//let domain = "https://mudrik.eu.auth0.com"
//let clientId = "l2g0AnHyRsxuHUNCd37ts1ZKZSX8XRBb"
//let callbackUrl = "vldmr.GitSearch://mudrik.eu.auth0.com/ios/vldmr.GitSearch/callback"

let domain = "https://github.com/login/oauth/"
let clientId = "b55b4bdb66738f59f553" //"l2g0AnHyRsxuHUNCd37ts1ZKZSX8XRBb"
let callbackUrl = "vldmr.GitSearch://mudrik.eu.auth0.com/ios/vldmr.GitSearch/callback"

struct Tokens {
    var accessToken: String
    var idToken: String?
    var refreshToken: String?
}

struct Profile {
    var name: String?
    var email: String?
}
