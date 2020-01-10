//
//  String.swift
//  NextUp
//
//  Created by Szymon Lorenz on 9/11/19.
//  Copyright © 2019 Szymon Lorenz. All rights reserved.
//

import Foundation

extension String {
    func base64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func isValidEmail() -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPred.evaluate(with: self)
    }
}
