//
//  File.swift
//  
//
//  Created by Max Nuding on 01.06.20.
//

import Foundation
import Publish

extension PublishingStep where Site == Groundphlegm {
    static func embedSvgStyles() -> Self {
        .step(named: "Embed CSS into SVG images") { context in
            let svgs = context.site.social.map {$0.icon}
            for svg in svgs {
                guard let svgContent = try? context.outputFile(at: Path(svg)) else {
                    continue
                }
                try svgContent.prepend(#"<?xml-stylesheet type="text/css" href="/svg.css"?>"#)
            }
        }
    }
}
