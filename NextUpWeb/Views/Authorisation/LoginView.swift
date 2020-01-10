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
    @EnvironmentObject var access: AccessToken
    @State var email: String = ""
    @State var password: String = ""
    @ObservedObject var alert: AlertMessage = AlertMessage()
    
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
                    VStack {
                        TabView {
                            SignupView().environmentObject(alert).tag(0).tabItem(Text("Sign Up"))
                            SigninView().environmentObject(alert).tag(1).tabItem(Text("Sign In"))
                        }
                        if alert.isShowing {
                            SCUIMessage(title: alert.header, message: alert.description, type: alert.style) {
                                self.alert.hide()
                            }
                        } else {}
                    }.padding()
                }
            }
        }
    }
}
