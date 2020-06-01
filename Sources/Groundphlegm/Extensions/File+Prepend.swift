//
//  File.swift
//  
//
//  Created by Max Nuding on 01.06.20.
//

import Foundation
import Files

extension File {
    /// - Warning: Reads a bunch of data into memory. Use only for small files and small amounts of data!
    func prepend(_ text: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = text.data(using: encoding) else {
            throw WriteError(path: path, reason: .stringEncodingFailed(text))
        }
        try prepend(data)
    }
    
    func prepend(_ data: Data) throws {
        /// - Warning: Reads a bunch of data into memory. Use only for small files and small amounts of data!
        do {
            let currentData = try self.read()
            let handle = try FileHandle(forWritingTo: url)
            var newData = data
            newData.append(currentData)
            handle.truncateFile(atOffset: 0)
            handle.write(newData)
            handle.closeFile()
        } catch {
            throw WriteError(path: path, reason: .writeFailed(error))
        }
    }
}
