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
        var detailsTitle: String? = nil
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://groundphlegm.wedro.online/")!
    var name = "Groundphlegm"
    var description = "Content-Type: text/nonsense"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var booklists = [Booklist.empty(for: "Currently Reading")]
    var social = SocialLink.all
    
    var dateTimeFormatter = DateFormatter(timeStyle: .medium, dateStyle: .medium)
    var dateFormatter: DateFormatter {
        let f = self.dateTimeFormatter
        f.timeStyle = .none
        return f
    }
    var timeFormatter: DateFormatter {
        let f = self.dateTimeFormatter
        f.dateStyle = .none
        return f
    }
}

let currentlyReading = Goodreads.currentlyReading()

try Groundphlegm(booklists: [currentlyReading]).publish(using: [
    .addMarkdownFiles(),
    .copyResources(at: "/Content/images", to: "/images", includingFolder: false),
    .copyResources(),
    .generateHTML(withTheme: .orange),
    .generateRSSFeed(including: [.posts]),
    .generateSiteMap(),
    .embedSvgStyles(),
    .deploy(using: .gitHub("hutattedonmyarm/Groundphlegm-Output", useSSH: true))
])

