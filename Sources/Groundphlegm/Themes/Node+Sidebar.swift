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
        return .div(
            .class("sidebar"),
            .forEach(site.booklists) { booklist in
                .booklist(for: booklist)
            }
        )
    }
}

extension Node where Context == HTML.BodyContext {
    static func booklist(for booklist: Booklist) -> Node {
        booklist.isEmpty ?
        .div() :
        .div(
            .class("booklist"),
            .span(.text(booklist.title)),
            .div(
                .class("booklist-content"),
                .forEach(booklist) { book in
                    .div(
                        .class("booklist-book"),
                        .img(.src(book.imageUrl.absoluteString), .class("cover")),
                        .div(.a(.href(book.url.absoluteString), .text(book.title)), .class("booktitle")),
                        .div(.text("By "), .text(book.authorList()), .class("bookauthor"))/*,
                        .div(.text(book.startedAt.formatted(withDateStyle: .medium, andTimeStyle: .none)), .class("bookstartdate"))*/
                    )
                }
            )
        )
    }
}
