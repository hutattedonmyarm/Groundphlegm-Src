//
//  File.swift
//  
//
//  Created by Max Nuding on 29.05.20.
//

import Foundation

// https://stackoverflow.com/questions/57693818/copying-resource-files-for-xcode-spm-tests

fileprivate let _auxillaryFiles: URL = {
    func packageRoot(of file: String) -> URL? {
        func isPackageRoot(_ url: URL) -> Bool {
            let filename = url.appendingPathComponent("Package.swift", isDirectory: false)
            return FileManager.default.fileExists(atPath: filename.path)
        }

        var url = URL(fileURLWithPath: file, isDirectory: false)
        repeat {
            url = url.deletingLastPathComponent()
            if url.pathComponents.count <= 1 {
                return nil
            }
        } while !isPackageRoot(url)
        return url
    }

    guard let root = packageRoot(of: #file) else {
        fatalError("\(#file) must be contained in a Swift Package Manager project.")
    }
    let fileComponents = URL(fileURLWithPath: #file, isDirectory: false).pathComponents
    let rootComponenets = root.pathComponents
    return URL(fileURLWithPath: rootComponenets.joined(separator: "/"), isDirectory: true)
}()

extension URL {
    init(forAuxillaryFile name: String, type: String) {
        let url = _auxillaryFiles.appendingPathComponent("\(name).\(type)", isDirectory: false)
        self = url
    }
}
