//
//  File.swift
//  
//
//  Created by Max Nuding on 01.06.20.
//

import Foundation
import Plot

extension Node where Context == HTML.BodyContext {
    static func svgObject(data: String, _ nodes: Node<HTML.BodyContext>...) -> Self {
        .element(named: "object", nodes: nodes + [
            .attribute(named: "type", value: "image/svg+xml"),
            .attribute(named: "data", value: data)
        ])
    }
}
