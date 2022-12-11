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
    
    func parseIntoWords() -> [String] {
        return  self.split(separator: " ").map { String($0) }
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

struct Matrix<T> {
    let rows: Int, columns: Int
    var grid: [T?]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: nil, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> T? {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    /*
       01234
     0 30373
     1 25512
     2 65332
     */
    func above(row: Int, column: Int) -> [T]? {
        guard row > 0 else{ return nil }
        // would love to get this a bit more elegant using functional approach but can't figure out how
        var array = [T]()
        var index = row - 1
        while index >= 0 {
            array.append(self[index, column]!)
            index -= 1
        }
        return array
    }
    
    func below(row: Int, column: Int) -> [T]? {
        guard row < rows-1 else{ return nil }
        var array = [T]()
        for r in row+1...rows-1 {
            array.append(self[r, column]!)
        }
        return array
    }
    
    func left(row: Int, column: Int) -> [T]? {
        guard column > 0 else { return nil }
        // array gotta be reversed because we need to iterate from the specified tree at the center
        return grid[(row * columns...(row * columns + column - 1))].map{$0!}.reversed()
    }
    
    func right(row: Int, column: Int) -> [T]? {
        guard column < columns-1 else { return nil }
        return grid[(row * columns + column + 1...(((row + 1) * columns-1)))].map{$0!}
    }
}
