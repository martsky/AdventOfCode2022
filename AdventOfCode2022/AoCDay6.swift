//
//  AoCDay6.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 07/12/2022.
//

import Foundation

class AoCDay6 {
    
    func process(_ input: String, markerLength: Int) -> Int? {
        for i in 0...input.count - markerLength {
            let sub: String = "" + input.dropFirst(i).prefix(markerLength)
            if Set(sub.split(separator: "")).count == markerLength {
                return i + markerLength
            }
        }
        return nil
    }
}
