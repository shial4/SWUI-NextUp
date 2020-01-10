//
//  AlertMessage.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 10/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//

import SwiftWebUI

#if canImport(Combine)
import class Combine.PassthroughSubject
#elseif canImport(OpenCombine)
import class OpenCombine.PassthroughSubject
#endif

class AlertMessage: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    private(set) var header: String = ""
    private(set) var description: String = ""
    private(set) var style: SCUIMessage.Style = .negative
    
    var isShowing: Bool = false { didSet { didChange.send(()) } }
    
    func show(title: String, message: String, type: SCUIMessage.Style = .negative) {
        header = title
        description = message
        style = type
        isShowing = true
    }
    
    func hide() {
        header = ""
        description = ""
        isShowing = true
    }
}

