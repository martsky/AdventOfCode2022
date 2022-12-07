//
//  AoCDay5.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 05/12/2022.
//

import Foundation

class Stack<T> {
    let number: Int
    var elements: [T]
    
    init(number: Int, elements: [T]) {
        self.number = number
        self.elements = elements
    }
    
    /// returns the top element
    /// - Returns: the top element
    func peek() -> T? {
        return elements.last
    }
    
    /// adds an element on top
    /// - Parameter element: element
    func push(element: T) {
        elements.append(element)
    }
    
    func pop() -> T? {
        let element = self.peek()
        elements.removeLast()
        return element
    }
    
    func pop(amount: Int) -> [T]? {
        guard elements.count >= amount else {
            return nil
        }
        let lastElemts = elements.suffix(amount).map { $0 }
        elements = elements.dropLast(amount).map { $0 }
        print("dropping\(lastElemts) from stack \(number)")
        return lastElemts
    }
    
    func push(newElements: [T]) {
        print("adding \(newElements) to stack \(number)")
        elements.append(contentsOf: newElements)
    }
    
    /// removes the top element
    /// - Parameter element: element of type t
    func poke(element: T) {
        elements.removeLast()
    }
}

struct Configuration {
    let stringRepresentation: String
    let numOfStacks: Int
    var stacks = [Int: Stack<String>]()
    
    
    /// input is lines in the form of
    ///     [D]
    /// [N] [C]
    /// [Z] [M] [P]
    ///  1   2   3
    /// - Parameter stringRepresentation:
    init(_ stringRepresentation: String) {
        self.stringRepresentation = stringRepresentation
        let lines: [String] = stringRepresentation.components(separatedBy: "\n")
        // determine the number of stacks. Its the leftmost number in the last line
        self.numOfStacks = Int(lines[lines.count-1].split(separator: " ").last!)!
        
        //create the number of stacks
        for i in 0...numOfStacks-1 {
            self.stacks[i] = Stack(number: i, elements: [String]())
        }
        // now we can load the configuration into Stacks. We have to get the bottom crates first, so we start with the last line
        // we know that the names of the crates are in "col 1 + numOfStack * 4"
        for line in lines[0...lines.count-2].reversed() {
            print("parsing line: \(line)")
            var i = 0;
            var pos = 1;
            while i < numOfStacks {
                if pos < line.count {
                    let char: String = String(line.dropFirst(pos).prefix(1))
                    print("i = \(i), pos = \(pos), char is \(char)")
                    if char != " " {
                        stacks[i]?.push(element: char)
                    }
                } else {
                    break
                }
                i += 1
                pos = 1 + i * 4
            }
        }
    }
    
    func description() -> String {
        var descr = ""
        for key in stacks.keys.sorted() {
            var d = "stack[\(key)]:"
            for crate: String in stacks[key]!.elements {
                d += crate
            }
            descr += d + "\n"
        }
        return descr
    }

    func parseConfigurationIntoLines(configuration: String) throws -> [String]{
        // how many stacks
        return configuration.components(separatedBy: "\n")
    }
    
    func getTopCrates() -> String {
        var result =  ""
        for stackNumbers in stacks.keys.sorted() {
            if let stack = stacks[stackNumbers], let top = stack.peek() {
                result += top
            }
        }
        return result
    }
    
    func execute1(_ instructionSet: InstructionsSet) {
        for instruction in instructionSet.instructions {
            print("move \(instruction.amount) from \(instruction.fromStack) to \(instruction.toStack)")
            print("before:\n\(description())")
            for _ in 0...instruction.amount-1{
                if let stack = stacks[instruction.fromStack] {
                    print("stack[\(stack.number) contains:\(stack.elements), count is \(stack.elements.count)")
                    guard let crate = stack.pop() else {
                        fatalError("Can't remove an element from a nil stack") }
                    stacks[instruction.toStack]?.push(element: crate)
                }
            }
            print("after:\n\(description())")
        }
    }
    
    func execute2(_ instructionSet: InstructionsSet) {
        for instruction in instructionSet.instructions {
            print("move \(instruction.amount) from \(instruction.fromStack) to \(instruction.toStack)")
            print("before:\n\(description())")
                if let stack = stacks[instruction.fromStack] {
                    print("stack[\(stack.number)] contains:\(stack.elements), count is \(stack.elements.count)")
                    guard let crates = stack.pop(amount: instruction.amount) else {
                        fatalError("Can't remove an element from a nil stack") }
                    stacks[instruction.toStack]?.push(newElements: crates)
                }
            print("after:\n\(description())")
        }
    }
}

struct Instruction {
    let fromStack: Int
    let toStack: Int
    let amount: Int
}

struct InstructionsSet {
    let stringRepresentation: String
    let instructions : [Instruction]
    
    init(_ stringRepresentation: String) {
        self.stringRepresentation = stringRepresentation
        let lines: [String] = stringRepresentation.split(separator: "\n").map { String($0) }
        var instructionsParsed =  [Instruction]()
        for line in lines {
            //move 1 from 2 to 1
            // split into "move 1" and "2 to 1"
            let parts = line.split(separator: " from ")
            print ("parts: \(parts)")
            let amount = Int(parts[0].dropFirst(5).suffix(3))!
            print ("amount: \(amount)")
            let partsFromTo = parts[1].split(separator: " ")
            print("partsFromTo: \(partsFromTo)")
            let fromStack = Int(partsFromTo[0])! - 1
            print("fromStack: \(fromStack)")
            let toStack = Int(partsFromTo[2])! - 1
            print("toStack \(toStack)")
            instructionsParsed.append(Instruction(fromStack: fromStack, toStack: toStack, amount: amount))
        }
        self.instructions = instructionsParsed
    }
}

class AoCDay5 {

    
    /// parses a String into the configuration part and the rearrangement pat
    ///    [D]
    ///[N] [C]
    ///[Z] [M] [P]
    /// 1      2      3
    ///
    /// move 1 from 2 to 1
    /// move 3 from 1 to 3
    /// move 2 from 2 to 1
    /// move 1 from 1 to 2
    /// - Parameter lines: the whole string
    /// - Returns:  [String] of dimension 2
    func parseIntoParts(lines: String) -> (Configuration, InstructionsSet){ // String[0] contains the configuration , String[1] the rearrangement part
        let parts = lines.components(separatedBy: "\n\n") // parts are split by an empty line
        guard parts.count == 2 else {
            fatalError("there should be 2 parts, but there were \(parts.count)")
        }
        let configuration = Configuration(parts[0])
        let instructions = InstructionsSet(parts[1])
        return (configuration, instructions)
    }
}
