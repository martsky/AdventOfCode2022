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

class Utils {
    
    static func readFile(_ fileName: String) throws -> String {
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") {
            // we found the file in our bundle!
            return try String(contentsOf: fileURL)
        } else {
            throw FileError.InvalidURl
        }
    }
}
