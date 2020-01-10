//
//  SigninView.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 10/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//

import Foundation
import SwiftWebUI
import Dispatch

struct SigninView: View {
    @EnvironmentObject var alert: AlertMessage
    @EnvironmentObject var access: AccessToken
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            TextField($email, placeholder: Text("Email"))
            SecureField($password, placeholder: Text("Password"))
            HStack(spacing: 20) {
                Spacer()
                SUILabel(Image(systemName: "sign in alternate")) { Text("Continue") }.onTapGesture {
                    self.signIn()
                }
            }.padding()
        }
    }
    
    func signIn() {
        let ws = CharacterSet.whitespacesAndNewlines
        let account = email.trimmingCharacters(in: ws)
        let pwd = password.trimmingCharacters(in: ws)
        
        guard !(account.isEmpty || pwd.isEmpty) else {
            alert.show(title: "Error", message: "Please enter an email and password.")
            return
        }
        
        guard account.isValidEmail() else {
            alert.show(title: "Error", message: "Please enter a valid email address.")
            return
        }
        do {
            self.access.cancellable = try User.signin(login: account, password: pwd)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        self.alert.show(title: "Something went wrong", message: error.localizedDescription)
                    }
                }, receiveValue: { response in
                    self.access.token = response.token
                })
        } catch let catchError {
            self.alert.show(title: "Something went wrong", message: catchError.localizedDescription)
        }
    }
}
