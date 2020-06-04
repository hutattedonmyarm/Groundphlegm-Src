//
//  File.swift
//  
//
//  Created by Max Nuding on 31.05.20.
//

import Foundation

protocol FontAwesomeIcon {
    var icon: String { get }
    var iconType: IconType { get }
    var embedCss: Bool { get }
}

struct Icon: FontAwesomeIcon {
    let icon: String
    let iconType: IconType
    let embedCss: Bool
}

struct SocialLink: FontAwesomeIcon {
    var embedCss: Bool = true
    let title: String
    let displayName: String
    let url: URL
    let iconType: IconType
    let icon: String
}

enum IconType {
    case brands
    case solid
    case regular
}

extension SocialLink {
    static var mastodon: SocialLink {
        return SocialLink(
            title: "Mastodon",
            displayName: "@aymm@metalhead.club",
            url: URL(string: "https://metalhead.club/@aymm")!,
            iconType: .brands,
            icon: "mastodon.svg"
        )
    }
    
    static var github: SocialLink {
        return SocialLink(
            title: "Github",
            displayName: "hutattedonmyarm",
            url: URL(string: "https://github.com/hutattedonmyarm")!,
            iconType: .brands,
            icon: "github.svg"
        )
    }
    
    static var twitter: SocialLink {
        return SocialLink(
            title: "Twitter",
            displayName: "@hutattedonmyarm",
            url: URL(string: "https://twitter.com/hutattedonmyarm")!,
            iconType: .brands,
            icon: "twitter.svg"
        )
    }
    
    static var email: SocialLink {
        return SocialLink(
            title: "Mail",
            displayName: "Max Nuding",
            url: URL(string: "mailto:max.nuding@icloud.com")!,
            iconType: .solid,
            icon: "envelope.svg"
        )
    }
}

extension SocialLink {
    static var all: [SocialLink] {
        [.mastodon, .github, .twitter, .email]
    }
    
    static var icons: [String] {
        all.map {"\($0.iconType)/\($0.icon)"}
    }
}
