//
//  File.swift
//  
//
//  Created by Max Nuding on 04.06.20.
//

import Foundation

protocol FontAwesomeIcon {
    var icon: String { get }
    var iconType: IconType { get }
    var embedCss: Bool { get }
}

struct Icon: FontAwesomeIcon, Equatable {
    let icon: String
    let iconType: IconType
    let embedCss: Bool
}

enum IconType {
    case brands
    case solid
    case regular
}
