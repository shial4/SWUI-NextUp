//
//  SignupView.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 10/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//

import Foundation
import SwiftWebUI

struct SignupView: View {
    @EnvironmentObject var alert: AlertMessage
    @EnvironmentObject var access: AccessToken
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    
    var body: some View {
        VStack {
            TextField($email, placeholder: Text("Email"))
            SecureField($password, placeholder: Text("Password"))
            SecureField($passwordConfirmation, placeholder: Text("Confirm Password"))
            HStack(spacing: 20) {
                Spacer()
                SUILabel(Image(systemName: "sign in alternate")) { Text("Continue") }.onTapGesture {
                    self.signUp()
                }
            }.padding()
        }
    }
    
    func signUp() {
        let ws = CharacterSet.whitespacesAndNewlines
        let account = email.trimmingCharacters(in: ws)
        let pwd = password.trimmingCharacters(in: ws)
        let pwdc = passwordConfirmation.trimmingCharacters(in: ws)
        
        guard !(account.isEmpty || pwd.isEmpty || pwdc.isEmpty), pwd == pwdc else {
            alert.show(title: "Error", message: "Please enter an email and password.")
            return
        }
        
        guard account.isValidEmail() else {
            alert.show(title: "Error", message: "Please enter a valid email address.")
            return
        }
        
        do {
            self.access.cancellable = try User.signup(email: account, password: pwd)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:  break
                    case .failure(let error):
                        self.alert.show(title: "Something went wrong", message: error.localizedDescription)
                    }
                }, receiveValue: { _ in
                    self.alert.show(title: "Success", message: "Your account is created. You can login now.", type: .success)
                })
        } catch let catchError {
            self.alert.show(title: "Something went wrong", message: catchError.localizedDescription)
        }
    }
}
