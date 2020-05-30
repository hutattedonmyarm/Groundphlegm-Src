//
//  File.swift
//  
//
//  Created by Max Nuding on 30.05.20.
//

import Foundation
import Plot

extension Node where Context == HTML.BodyContext {
    static func grid(id: String, _ nodes: Node...) -> Node {
        .div(
            .class("grid"),
            .id(id),
            .group(nodes)
        )
    }
}
