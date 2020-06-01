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
        return .group(
            .h1(markdown(item.title)),
            .p(
                .class("pubdate"),
                .text("Published: "),
                .time(.datetime(item.date), .text(site.dateFormatter.string(from: item.date)))
            ),
            .contentBody(item.body)
        )
    }
}

