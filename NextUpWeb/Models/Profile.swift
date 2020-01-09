//
//  Profile.swift
//  NextUp
//
//  Created by Szymon Lorenz on 16/12/19.
//  Copyright © 2019 Szymon Lorenz. All rights reserved.
//

import Foundation
import Combine

struct GeoPoint: Codable {
    let longitude: Double
    let latitude: Double
}

enum Gender: Int, Codable {
    case male
    case female
    case other
}

struct Profile: Codable {
    var coordinates: GeoPoint?
    var userName: String?
    var firstName: String?
    var lastName: String?
    var birthday: Date?
    var gender: Gender?
    var bio: String?
    
    //MARK API operations
    static func get(_ token: String) throws -> AnyPublisher<Profile, DataTaskError> {
        let url = "\(urlBase)/profiles"
        var request = try URLRequest(urlString: url)
        request.headers([
            "Authorization":"Bearer \(token)"
        ])
        return URLSession.shared.data(request: request)
    }

    func update(_ token: String) throws -> AnyPublisher<Profile, DataTaskError> {
        let url = "\(urlBase)/profiles"
        var request = try URLRequest(urlString: url)
        request.method(.POST)
        request.headers([
            "Authorization":"Bearer \(token)",
            "Content-Type":"application/json"
        ])
        request.body(try JSONEncoder().encode(self))
        return URLSession.shared.data(request: request)
    }
}
