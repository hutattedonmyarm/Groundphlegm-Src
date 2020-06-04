//
//  File.swift
//  
//
//  Created by Max Nuding on 01.06.20.
//

import Foundation
import Plot
import Publish
import Ink

extension Node where Context == HTML.BodyContext {
    static func post(for item: Item<Groundphlegm>, on site: Groundphlegm) -> Node {
        
        return .group(
            .h1(
                .markdownTitle(for: item),
                .if(item.tags.contains(Tag("link")), .svgObject(data: "/" + Icon.link.icon))
            ),
            .p(
                .class("pubdate"),
                .text("Published: "),
                .time(.datetime(item.date), .text(site.dateFormatter.string(from: item.date)))
            ),
            .contentBody(item.body)
        )
    }
}

