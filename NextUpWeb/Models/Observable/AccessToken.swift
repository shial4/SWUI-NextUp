//
//  AccessToken.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 10/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//
import SwiftWebUI

#if canImport(Combine)
import class Combine.AnyCancellable
import class Combine.PassthroughSubject
#elseif canImport(OpenCombine)
import class OpenCombine.AnyCancellable
import class OpenCombine.PassthroughSubject
#endif

class AccessToken: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    var token: String? = nil { didSet { didChange.send(()) } }
    var cancellable: AnyCancellable?
    var isLoggedIn: Bool { token != nil }
}
