//
//  MainView.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 8/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//

import Foundation
import SwiftWebUI

struct MainView: View {
    @ObservedObject var access = AccessToken()
    
    var body: some View {
        if let _ = access.token {
            return AnyView(
                VendorView(vendors: [
                    Vendor(id: 1, ownerID: ["1"], createdAt: Date(), updatedAt: Date(), title: "title 1", description: "some new text 1", image: nil),
                    Vendor(id: 2, ownerID: ["2"], createdAt: Date(), updatedAt: Date(), title: "title 2", description: "some new text 2", image: nil)
                    ])
                .environmentObject(access)
            )
        }
        return AnyView(LoginView().environmentObject(access))
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
