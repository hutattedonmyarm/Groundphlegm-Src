//
//  File.swift
//  
//
//  Created by Max Nuding on 24.05.20.
//

import Plot
import Publish

extension Theme where Site == Groundphlegm {
    /// A light and dark theme with an orange accent
    static var orange: Self {
        Theme(
            htmlFactory: OrangeHTMLFactory(),
            resourcePaths: Set(["Resources/OrangeTheme/styles.css", "Resources/OrangeTheme/svg.css"] + SocialLink.icons.map{"Resources/OrangeTheme/svgs/\($0)"})
        )
    }
}

extension HTML {
    class HeadBaseContext {}
}

extension Attribute where Context == HTML.HeadBaseContext {
    static func href(_ url: String) -> Self {
        return .attribute(named: "href", value: url)
    }
}


extension Node where Context == HTML.HeadContext {
    static func base(_ attributes: Attribute<HTML.HeadBaseContext>...) -> Self {
        .selfClosedElement(named: "base", attributes: attributes)
    }
}

extension Node where Context == HTML.DocumentContext {
    /// Add an HTML `<head>` tag within the current context, based
    /// on inferred information from the current location and `Website`
    /// implementation.
    /// - parameter location: The location to generate a `<head>` tag for.
    /// - parameter site: The website on which the location is located.
    /// - parameter titleSeparator: Any string to use to separate the location's
    ///   title from the name of the website. Default: `" | "`.
    /// - parameter stylesheetPaths: The paths to any stylesheets to add to
    ///   the resulting HTML page. Default: `styles.css`.
    /// - parameter rssFeedPath: The path to any RSS feed to associate with the
    ///   resulting HTML page. Default: `feed.rss`.
    /// - parameter rssFeedTitle: An optional title for the page's RSS feed.
    static func head<T: Website>(
        for location: Location,
        on site: T,
        nodes: [Node<HTML.HeadContext>] = [Node<HTML.HeadContext>](),
        titleSeparator: String = " | ",
        stylesheetPaths: [Path] = ["/styles.css"],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil
    ) -> Node {
        var title = location.title

        if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }
        //let base = Node<HTML.HeadContext>.base(.href("https://groundphlegm.wedro.online/"))

        let h = Node.head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            }),
            .group(nodes)
        )
        return h
    }
}

private struct OrangeHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Groundphlegm>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site, nodes: [Node<HTML.HeadContext>.base(.href(context.site.url.absoluteString))]),
            .body(
                .header(for: context, selectedSection: nil),
                .grid(
                    .class("grid main-grid"),
                    .sidebar(for: context.site),
                    .wrapper(
                        .class("wrapper main-wrapper"),
                        .h1(.text(index.title)),
                        .p(
                            .class("description"),
                            .text(context.site.description)),
                        .h2("Latest content"),
                        .itemList(
                            for: context.allItems(
                              sortedBy: \.date,
                              order: .descending
                            ),
                            on: context.site
                        )
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .grid(
                    .class("grid main-grid"),
                    .sidebar(for: context.site),
                    .wrapper(
                        .class("wrapper main-wrapper"),
                        .h1(.text(section.title)),
                        .itemList(for: section.items, on: context.site)
                      )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Groundphlegm>,
                      context: PublishingContext<Groundphlegm>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .grid(
                    .class("grid main-grid"),
                    .sidebar(for: context.site),
                    .wrapper(
                        .class("wrapper main-wrapper"),
                        .article(
                            .div(
                                .class("content"),
                                .post(for: item, on: context.site)
                            ),
                            .span("Tagged with: "),
                            .tagList(for: item, on: context.site)
                        )
                      )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Groundphlegm>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Groundphlegm>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .grid(
                    .class("grid main-grid"),
                    .sidebar(for: context.site),
                    .wrapper(
                        .class("wrapper main-wrapper"),
                        .h1("Browse all tags"),
                        .ul(
                            .class("all-tags"),
                            .forEach(page.tags.sorted()) { tag in
                                .li(
                                    .class("tag"),
                                    .a(
                                        .href(context.site.path(for: tag)),
                                        .text(tag.string)
                                    )
                                )
                            }
                        )
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Groundphlegm>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .grid(
                    .class("grid main-grid"),
                    .wrapper(
                        .class("wrapper main-wrapper"),
                        .h1(
                            "Tagged with ",
                            .span(.class("tag"), .text(page.tag.string))
                        ),
                        .a(
                            .class("browse-all"),
                            .text("Browse all tags"),
                            .href(context.site.tagListPath)
                        ),
                        .itemList(
                            for: context.items(
                                taggedWith: page.tag,
                                sortedBy: \.date,
                                order: .descending
                            ),
                            on: context.site
                        )
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .a(.class("site-name"), .href("/"), .text(context.site.name)),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                        })
                    )
                )
            )
        )
    }

    static func itemList(for items: [Item<Groundphlegm>], on site: Groundphlegm) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(
                        .a(
                            .href(item.path),
                            .markdown(item.title)
                        )
                    ),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            ))
        )
    }
}
