//
//  SUIMessage.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 9/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//

import Foundation
import SwiftWebUI

struct SCUIMessage: View {
    enum Style { case negative, success }
    
    @State var style: Style = .negative
    var title: String
    var message: String
    var closeAction: (() -> Void)
    
    init(title: String, message: String, onClose: @escaping () -> Void) {
        self.title = title
        self.message = message
        closeAction = onClose
    }
    
    private func close() { closeAction() }
    
    var body: some View {
        HTMLContainer(classes: [ "ui", "\(style)", "message" ]) {
            HStack {
                Spacer()
                HTMLContainer("i", classes: [ "close", "icon" ], body: { EmptyView() }).onTapGesture { self.close() }
            }
            HTMLContainer(classes: [ "header" ], body: { Text(title) })
            HTMLContainer("p", classes: [ ], body: { Text(message) })
        }
    }
}
