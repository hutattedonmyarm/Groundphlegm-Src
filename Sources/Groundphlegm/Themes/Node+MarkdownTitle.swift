//
//  File.swift
//  
//
//  Created by Max Nuding on 03.06.20.
//

import Foundation
import Plot
import Publish
import Ink

extension Node {
    static func markdownTitle(for item: Item<Groundphlegm>, parser: MarkdownParser = .init()) -> Node {
        let md = parser.parse(item.metadata.detailsTitle ?? item.title)
        var html = md.html
        if html.hasPrefix("<p>") && html.hasSuffix("</p>") {
            html = html.dropFirst(3).dropLast(4).description
        }
        return .raw(html)
    }
}
