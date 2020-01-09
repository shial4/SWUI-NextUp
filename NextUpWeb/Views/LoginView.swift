//
//  LoginView.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 8/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//

import Foundation
import SwiftWebUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var alert: (header: String, message: String)? = nil
    
    var isShowingAlert: Bool {
        alert != nil
    }
    
    func hideMessage() {
        print("hideMessage")
        self.alert = nil }
    
    var body: some View {
        SUICards {
            SUICard(Image.unsplash(size: UXSize(width: 200, height: 200),
                                   "festival", "event"),
                    Text("NextUP"),
                    meta: Text("Login or creat your account to continiue"))
            {
                VStack {
                    Text("Next Up")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                    TextField($email, placeholder: Text("Email"))
                    TextField($password, placeholder: Text("Password"))
                    VStack {
                        HStack(spacing: 20) {
                            Spacer()
                            SUILabel(Image(systemName: "sign in alternate")) { Text("Login") }.onTapGesture {
                                self.signIn()
                            }
                        }
                        if isShowingAlert {
                            SCUIMessage(title: alert?.header ?? "", message: alert?.message ?? "") {
                                self.hideMessage()
                            }
                        } else {}
                    }.padding()
                }
            }
        }
    }
    
    internal func isEmailValid(_ email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPred.evaluate(with: email)
    }
    
    internal func signIn() {
        let ws = CharacterSet.whitespacesAndNewlines
        let account = email.trimmingCharacters(in: ws)
        let pwd = password.trimmingCharacters(in: ws)
        
        guard !(account.isEmpty || pwd.isEmpty) else {
            alert = ("Error","Please enter an email and password.")
            return
        }
        
        guard isEmailValid(account) else {
            alert = ("Error","Please enter a valid email address.")
            return
        }
        
        _ = try! User.signin(login: account, password: pwd)
            .receive(on: OperationQueue.main)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self.alert = ("Something went wrong", error.localizedDescription)
            }
        }, receiveValue: { token in
            
        })
    }
}
