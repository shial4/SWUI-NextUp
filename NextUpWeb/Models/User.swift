//
//  User.swift
//  NextUp
//
//  Created by Szymon Lorenz on 1/11/19.
//  Copyright © 2019 Szymon Lorenz. All rights reserved.
//

import Foundation
import Combine

struct User: Decodable {
    var id: Int?
    var externalId: String?
    var externalService: String?
    var email: String?
    
    var nextUp: Token?
    
    private enum CodingKeys: String, CodingKey {
        case id, externalId, externalService, email
    }
    
    //MARK API operations
    static func signin(login: String, password: String) throws -> AnyPublisher<Token, DataTaskError> {
        let url = "\(urlBase)/users/login"
        var request = try URLRequest.init(urlString: url)
        request.headers([
            "Authorization":"Basic \("\(login):\(password)".base64())"
        ])
        return URLSession.shared.data(request: request)
    }
    
    static func signup(email: String, password: String) throws -> AnyPublisher<User, DataTaskError> {
        let url = "\(urlBase)/users/create"
        var request = try URLRequest(urlString: url)
        request.method(.POST)
        request.headers(["Content-Type":"application/json"])
        request.body("""
{
    "email":"\(email)",
    "password":"\(password)",
    "verifyPassword":"\(password)"
}
""")
        return URLSession.shared.data(request: request)
    }
}
