//
//  AocDay3.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 03/12/2022.
//

import Foundation

class AoCDay3 {
    var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split(separator: "")
    let puzzle2SampleInput =
    """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""
    func puzzle2() throws -> String {
        

        let input = try Utils.readFile("inputRucksacks")
//        let input = puzzle2SampleInput
        // group rucksacks
        let ruckSacks = input.components(separatedBy: "\n")
        // take the first rucksack and compare for all chars whether the following 3 rucksacks contain that char
        var counter = 0;
        var sharedItems = [Int]()
        while counter + 2 < ruckSacks.count {
            var sharedItem: Character = Character("!")
            for component in ruckSacks[counter] {
                if ruckSacks[counter + 1].contains(component) && ruckSacks[counter + 2].contains(component){
                    sharedItem = component
                    let score = chars.firstIndex(of: "\(sharedItem)")! + 1
                    print("shared item = \(sharedItem) with score \(score)")
                    sharedItems.append(score)
                    break
                }
            }
            counter += 3
        }
        return "score is \(sharedItems.reduce(0, +))"
    }
    
    func puzzle1() throws -> String {
        let input = try Utils.readFile("inputRucksacks")
        let ruckSacks = input.components(separatedBy: "\n") // split into [String] of lines
            .map { rucksack in
                let l = rucksack.count / 2
                print(l)
                let c1 = rucksack.prefix(l)
                let c2 = rucksack.suffix(l)
                return [c1, c2]
            } // now we have each rucksack with 2 compartments
        var score = 0
        for ruckSack in ruckSacks {
            var sharedItem: Character = Character("!")
            print("comparing \(ruckSack[0]) and \(ruckSack[1])")
            for component in ruckSack[0] {
                if ruckSack[1].contains(component) {
                    sharedItem = component
                    print("item = \(sharedItem)")
                    break
                }
            }
            if let index = chars.firstIndex(of: "\(sharedItem)") {
                print("index = \(index)")
                score += index + 1
            }
        }
        return ("Score is \(score)")
    }
}
