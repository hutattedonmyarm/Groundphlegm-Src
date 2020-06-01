//
//  File.swift
//  
//
//  Created by Max Nuding on 01.06.20.
//

import Foundation
import Plot

extension HTML {
    class TimeContext {}
}

extension ISO8601DateFormatter {
    public convenience init(options: Options) {
        self.init()
        self.formatOptions = options
    }
}

extension ISO8601DateFormatter.Options {
    static var fullFormat: ISO8601DateFormatter.Options = [.withYear, .withMonth, .withDay, .withTime, .withTimeZone, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
    static var dateFormat: ISO8601DateFormatter.Options = [.withYear, .withMonth, .withDay, .withDashSeparatorInDate]
    static var timeFormat: ISO8601DateFormatter.Options = [.withTime, .withTimeZone, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
}

extension Node where Context == HTML.TimeContext {
    static func datetime(_ date: Date, formatOptions: ISO8601DateFormatter.Options = .fullFormat) -> Self {
        return .attribute(named: "datetime", value: ISO8601DateFormatter(options: formatOptions).string(from: date))
    }
}


extension Node where Context == HTML.BodyContext {
    static func time(_ nodes: Node<HTML.TimeContext>...) -> Self {
        .element(named: "time", nodes: nodes)
    }
}
