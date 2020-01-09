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
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
