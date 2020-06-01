//
//  File.swift
//  
//
//  Created by Max Nuding on 01.06.20.
//

import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func post(for item: Item<Groundphlegm>, on site: Groundphlegm) -> Node {
        .group(
            .h1(.text(item.title)),
            .p(
                .class("pubdate"),
                .text("Published: "),
                .time(.datetime(item.date), .text(site.dateFormatter.string(from: item.date)))
            ),
            .contentBody(item.body)
        )
    }
}

