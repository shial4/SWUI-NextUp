//
//  Token.swift
//  NextUp
//
//  Created by Szymon Lorenz on 9/11/19.
//  Copyright © 2019 Szymon Lorenz. All rights reserved.
//

import Foundation

class Token: Decodable {
    let expiresAt: String
    let token: String
    let userID: Int
    let id: Int
}
