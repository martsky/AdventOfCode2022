//
//  AocDay2.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 03/12/2022.
//

import Foundation

struct Hand: Comparable {
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        return lhs.value < rhs.value
    }
    
    let value: String
}

class Game {
    
}

class AocDay2 {
    let wins = ["A Y", "B Z", "C X"]
    let losses = ["A Z", "B X", "C Y"]
    let draws = ["A X", "B Y", "C Z"]
    
    
    
    
    func splitIntoArrays(_ input: String) -> [[String]] {
        // convert input to [[Int, Int]]
        let pairs: [[String]]  = input
            .split(separator: "\n")
            .map { $0.components(separatedBy:" ") } //->  [A X],[A X] ->[[A,X]]
        return pairs
    }
    
    func day2Score2() throws -> String {
        let handValues = ["A": 1, "B":2, "C":3]
        let winWith = ["A":"B" , "B":"C", "C":"A"]
        let drawWith = ["A":"A" , "B":"B", "C":"C"]
        let looseWith = ["A":"C" , "B":"A", "C":"B"]
        let strategyScore = ["X": 0, "Y": 3, "Z": 6]
        
        let input = try Utils.readFile("inputday2")
        let rounds = splitIntoArrays(input)
        let result = rounds.map { roundArr in
            var score = 0;
            let oppHand = roundArr[0]
            let yourStrategy = roundArr[1]
            score += strategyScore[yourStrategy]!
            var yourHand = ""
            switch yourStrategy {
            case "X":
                yourHand = looseWith[oppHand]!
            case "Y":
                yourHand = drawWith[oppHand]!
            case "Z":
                yourHand = winWith[oppHand]!
            default:
                assertionFailure("invalid value")
            }
            score += handValues[yourHand]!
            return score
        }.reduce(0, +)
        return "result is \(result)"
    }
    
    func day2Score1() throws -> String {
        let input = try Utils.readFile("inputday2")
        let rounds: [String]  = input.components(separatedBy: "\n")
        var total = 0
        var roundNr = 0
        for round in rounds {
            roundNr += 1
            
            var roundScore = 0
            if !round.isEmpty {
                print("\(round)")
                if wins.contains(round) {
                    roundScore += 6
                } else if draws.contains(round) {
                    roundScore += 3
                }
                switch round.suffix(1) {
                case "X":
                    roundScore += 1
                case "Y":
                    roundScore += 2
                case "Z":
                    roundScore += 3
                default:
                    assertionFailure("invalid parsing")
                }
                total += roundScore
            }
            print("score of round \(roundNr) is \(roundScore) totalling to \(total)")
            
        }
        return ("score is : \(total)")
    }
    
    
    //    func day2Score() -> String {
    //        let input = Utils.readFile("inputday2")
    //        let pairsArray = splitIntoArrays(input)
    //        let resultArr: [Int] = pairsArray.map { arr in
    //            var yourValue = 0;
    //            switch arr[1] {
    //            case "A":
    //                yourValue = 1
    //            case "B":
    //                yourValue = 2
    //            case "C":
    //                yourValue = 3
    //            default:
    //                    assertionFailure("invalid value")
    //            }
    //            if arr[0] == arr[1] { // draw
    //                yourValue += 3
    //            }
    //            // A < B < C < A
    //            if (arr[0] == "C" && arr[1] == "A") || (arr[0] < arr[1])  { // i win
    //                yourValue += 6
    //            }
    //            if yourValue == 0 {
    //                assertionFailure("invalid value")
    //            }
    //            print ("score for arr\(arr.description) : \(yourValue)")
    //            return yourValue
    //        }
    //        assert(resultArr.count == 2500, "there should be 2500 scores")
    //        var total = 0
    //        for score in resultArr {
    //            total += score
    //        }
    //        print ("total score in for loop is \(total)")
    //        let result = resultArr.reduce(0, +)
    //        return "Score is \(result)"
    //    }
}
