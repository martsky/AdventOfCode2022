//
//  Utils.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 03/12/2022.
//


import Foundation

enum FileError: Error {
    case InvalidURl
    case InvalidString
}

extension String {
    func parseIntoLines() -> [String] {
        return  self.split(separator: "\n").map { String($0) }
    }
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}

class Utils {
    
    static func readFile(_ fileName: String) throws -> String {
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") {
            // we found the file in our bundle!
            return try String(contentsOf: fileURL)
        } else {
            throw FileError.InvalidURl
        }
    }
    
    static func parseIntoLines(_ input: String) -> [String] {
        return  input.split(separator: "\n").map { String($0) }
    }
}
