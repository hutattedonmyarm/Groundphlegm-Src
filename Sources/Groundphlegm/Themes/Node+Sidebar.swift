//
//  File.swift
//  
//
//  Created by Max Nuding on 30.05.20.
//

import Foundation
import Plot

extension Node where Context == HTML.BodyContext {
    static func sidebar(for site: Groundphlegm) -> Node {
        return .aside(
            .class("sidebar"),
            .forEach(site.booklists) { booklist in
                .booklist(for: booklist)
            },
            .social(for: site)
        )
    }
}

extension Node where Context == HTML.BodyContext {
    static func social(for site: Groundphlegm) -> Node {
        .if(!site.social.isEmpty,
            .div(
                .class("list contact-item"),
                .span(.text("Social")),
                .forEach(site.social) { socialLink in
                    .div(
                        .svgObject(
                            data: "/\(socialLink.icon)",
                            .class("social svg-image"),
                            .attribute(named: "role", value: "img"),
                            .attribute(named: "title", value: socialLink.title)),
                        .a(
                            .href(socialLink.url.absoluteString),
                            .text(socialLink.displayName),
                            .if(socialLink == .mastodon, .attribute(named: "rel", value: "me"))
                        )
                    )
                }
            ),
            else: .div()
        )
    }
    
    static func booklist(for booklist: Booklist) -> Node {
        .if(!booklist.isEmpty,
            .div(
                .class("list"),
                .span(.text(booklist.title)),
                .div(
                    .class("booklist-content"),
                    .forEach(booklist) { book in
                        .div(
                            .class("booklist-book"),
                            .img(.src(book.imageUrl.absoluteString), .class("cover"), .alt("Cover for \(book.title)")),
                            .div(.a(.href(book.url.absoluteString), .text(book.title)), .class("booktitle")),
                            .div(.text("By "), .text(book.authorList()), .class("bookauthor"))
                        )
                    }
                )
            ),
            else: .div()
        )
    }
}
