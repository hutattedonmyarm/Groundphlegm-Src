//
//  File.swift
//  
//
//  Created by Max Nuding on 25.05.20.
//

import Foundation

struct Booklist {
    let title: String
    let books: [Book]
    
    static func empty(for title: String) -> Booklist {
        Booklist(title: title, books: [Book]())
    }
}

extension Booklist: Collection {
    //https://www.swiftbysundell.com/articles/creating-custom-collections-in-swift/
    // Required nested types, that tell Swift what our collection contains
    typealias Element = Book
    typealias Index = Int
    

    // The upper and lower bounds of the collection, used in iterations
    var startIndex: Index { return books.startIndex }
    var endIndex: Index { return books.endIndex }

    // Required subscript, based on a dictionary index
    subscript(index: Index) -> Iterator.Element {
        get { return books[index] }
    }

    // Method that returns the next index when iterating
    func index(after i: Index) -> Index {
        return books.index(after: i)
    }
}

struct Book: Decodable {
    let bookId: String
    let workId: String
    let url: URL
    let title: String
    let imageUrl: URL
    let startedAt: Date
    let authors: [String]
    
    func authorList() -> String {
        authors.sorted() {
            guard let aLastname = $0.components(separatedBy: CharacterSet.whitespaces).last else {
                return false
            }
            guard let bLastname = $1.components(separatedBy: CharacterSet.whitespaces).last else {
                return true
            }
            
            return aLastname < bLastname
        }.joined(separator: ", ")
    }
}

struct Goodreads {
    static func currentlyReading() -> Booklist {
        let title = "Currently Reading"
        let currentlyReadingFile = URL(forAuxillaryFile: "currently_reading", type: "json")
        guard let contents = FileManager.default.contents(atPath: currentlyReadingFile.path) else {
            print("\(currentlyReadingFile.path) not found!")
            return Booklist(title: title, books: [Book]())
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var books = [Book]()
        do {
            books = try decoder.decode([Book].self, from: contents)
        } catch {
            print("Decoding error: \(error)")
        }
        return Booklist(title: title, books: books)
    }
}
