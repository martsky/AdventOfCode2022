//
//  AoCDay11.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 11/12/2022.
//

import Foundation

enum Operator: String {
    case addOp = "+"
    case multOp = "*"
    case squareOp = "**"
}

struct Operation {
    let op: Operator
    let operand: Int
    
    func calcWorryLevel(old: Int) -> Int {
        var newWorryLevel = 0
        switch op {
        case .multOp:
            newWorryLevel = old * operand
        case .addOp:
            newWorryLevel =  old + operand
        case .squareOp:
            newWorryLevel =  old * old
        }
        print ("new: \(newWorryLevel) = \(old) \(op) \(operand)")
        return newWorryLevel
    }
}
class Monkey {
    var id: Int
    var items:  [Int]
    let operation: Operation
    let testDivisible: Int
    let outcome: [Bool: Int]
    var inspected = 0
    
    init(id: Int, items: [Int], operation: Operation, testDivisible: Int, outcome: [Bool : Int]) {
        self.id = id
        self.items = items
        self.operation = operation
        self.testDivisible = testDivisible
        self.outcome = outcome
    }
    
    func operation(item: Int, manageWorryLevel:(_ worryLevel: Int) ->(Int)) -> Int {
        inspected += 1
        print("Monkey[\(id)]")
        var worryLevel = operation.calcWorryLevel(old: item)
        // reduce worry level for part 1 of the puzzle
        worryLevel = manageWorryLevel(worryLevel)
        return worryLevel

    }
    
    func throwTo(item: Int) -> Int {
        let throwToMonkey = outcome[item % testDivisible == 0]!
        print("throwing \(item) to \(throwToMonkey)")
        return throwToMonkey
    }
    

    
}

class KeepAwayGame {
    var monkeys = [Int:Monkey]()
    var worryLevel: Int = 0
    
    func inspectItems(monkey: Monkey, manageWorryLevel:  @escaping (Int) -> Int) {
        for item in monkey.items {
            monkey.items.removeFirst() // remove the item from the current monkey
            let newItem = monkey.operation(item: item, manageWorryLevel:manageWorryLevel)
            let throwTo = monkey.throwTo(item: newItem)
            monkeys[throwTo]!.items.append(newItem)
        }
    }
    
    func parse(lines: [String]) {
        let monkeyDefLength = 6 // split seems to ignore empty lines
        var i = 0
        while i + monkeyDefLength < lines.count+1 {
            let items: [Int] = lines[i+1].split(separator: ": ")[1].split(separator: ", ").map { Int($0)! }
            let id = Int(lines[i].prefix(lines[i].count-1).split(separator: " ")[1])!
            let operationParams = lines[i+2].split(separator: "= old ")[1].split(separator: " ").map {String($0)}
            // the operand can be an int or "old" i.e nwe = old * old so it becomes a square operation in case of mult or * 2 operation
            // we can't deal with more than 1 operand
            var operand = 0
            var op = Operator(rawValue:operationParams[0])!
            if operationParams[1] == "old" {
                if op == .multOp {
                    op = .squareOp
                }
            } else {
                operand = Int(operationParams[1])!
            }

            let operation = Operation(op: op , operand: operand)
            let divisibleBy = lines[i+3].split(separator: " ").map{ Int( $0) }.last!!
            let outcomeTrue = lines[i+4].split(separator: " ").map{ Int( $0) }.last!!
            let outcomeFalse = lines[i+5].split(separator: " ").map{ Int( $0) }.last!!
            let outcome: [Bool:Int] = [true: outcomeTrue, false: outcomeFalse]
            let monkey = Monkey(id: id, items: items, operation: operation, testDivisible: divisibleBy, outcome: outcome)
            monkeys[monkey.id] = monkey
            i += monkeyDefLength
        }
    }
}

class AoCDay11 {
    
 
}
