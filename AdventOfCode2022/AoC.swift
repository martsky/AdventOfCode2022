//
//  AoC.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 03/12/2022.
//

import Foundation
class AoCDay1 {
    
    func calcSumsOfElves (_ inputCals: String) -> [Int] {
        let sums = inputCals.split(separator: "\n\n") // split into [String\nString\nString, String\nString\nString]
            .map { $0.split(separator: "\n")} //[[String, String, String]]
            .map { $0.map { Int($0)!}} // [[Int, Int, Int],[Int, Int, Int]]
            .map { $0.reduce(0) { $0 + $1 } // [Sum, Sum, Sum]
            }
        return sums
    }
    
    private func calcTopThreeCals (sums: [Int]) -> [Int] {
        let arr = Array(sums.sorted(by: >)[0...2])
        print(arr)
        return arr
    }
    
    func day1MaxCals() throws -> String {
        let inputCals = try Utils.readFile("inputCals")
        let maxCals = calcSumsOfElves(inputCals).max()
        return "result is: \(String(describing: maxCals))"
    }
    
    func day1TopThreeCals() throws -> String {
        let inputCals = try Utils.readFile("inputCals")
        let sumCals = calcSumsOfElves(inputCals)
        let top3 = calcTopThreeCals(sums: sumCals).reduce(0, +)
        return "top3 sum is: \(String(describing: top3))"
    }

}
