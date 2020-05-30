import Foundation
import Publish
import Plot
import OAuthSwift

// This type acts as the configuration for your website.
struct Groundphlegm: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://www.wedro.online/Groundphlegm")!
    var name = "Groundphlegm"
    var description = "Mostly nonsense"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var booklists = [Booklist.empty(for: "Currently Reading")]
}

let currentlyReading = Goodreads.currentlyReading()

// This will generate your website using the built-in Foundation theme:
try Groundphlegm(booklists: [currentlyReading])
    .publish(withTheme: .orange)

