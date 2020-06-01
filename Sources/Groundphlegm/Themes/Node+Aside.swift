//
//  File.swift
//  
//
//  Created by Max Nuding on 01.06.20.
//

import Foundation
import Plot

extension Node where Context == HTML.BodyContext {
    static func aside(_ nodes: Node<HTML.BodyContext>...) -> Self {
        .element(named: "aside", nodes: nodes)
    }
}
