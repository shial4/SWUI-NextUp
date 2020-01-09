//
//  MainView.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 8/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//

import Foundation
import SwiftWebUI

#if false // duplicate ObservableObject
  #if canImport(Combine)
    import Combine
  #elseif canImport(OpenCombine)
    import OpenCombine
  #endif
#else
  #if canImport(Combine)
    import class Combine.PassthroughSubject
  #elseif canImport(OpenCombine)
    import class OpenCombine.PassthroughSubject
  #endif
#endif
import SwiftWebUI

class AccessToken: ObservableObject {
  static let global = AccessToken()
  var didChange = PassthroughSubject<Void, Never>()
  var token: String? = nil { didSet { didChange.send(()) } }
}

struct MainView: View {
    @ObservedObject var access = AccessToken.global
    
    var body: some View {
        if let _ = access.token {
            return AnyView(
                VendorView(vendors: [
                    Vendor(id: 1, ownerID: ["1"], createdAt: Date(), updatedAt: Date(), title: "title 1", description: "some new text 1", image: nil),
                    Vendor(id: 2, ownerID: ["2"], createdAt: Date(), updatedAt: Date(), title: "title 2", description: "some new text 2", image: nil)
                    ])
            )
        }
        return AnyView(LoginView())
    }
}


/**
 import SwiftWebUI

 typealias SWUIObservableObject = ObservableObject

 class AccessToken: ObservableObject {
     var didChange = PassthroughSubject<Void, Never>()
     var value: String { didSet { didChange.send(()) } }
     
     init(value: String) {
         self.value = value
     }
 }
*/
