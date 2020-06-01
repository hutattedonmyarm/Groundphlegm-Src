//
//  File.swift
//  
//
//  Created by Max Nuding on 01.06.20.
//

import Foundation

extension DateFormatter {
    convenience init(timeStyle: Style, dateStyle: Style) {
        self.init()
        self.timeStyle = timeStyle
        self.dateStyle = dateStyle
    }
}
