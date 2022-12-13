//
//  AoCDay10.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 10/12/2022.
//

import Foundation


enum CommCommand: String {
    case noop = "noop"
    case addx = "addx"
}

class CommInstruction {
    let cmd: CommCommand
    let param: Int?
    var executed = false
    var countdown: Int // counts down from the given value to 0. If 0 the command is excecuted, i.e. the param added to Xs
    
    init(cmd: CommCommand, param: Int?) {
        self.cmd = cmd
        self.param = param
        switch self.cmd {
        case .noop:
            self.countdown = 1
        case .addx:
            self.countdown = 2
        }
        if param == 0 {
            assertionFailure("params of 0 not expected and not correcly handled by the program")
        }
    }
    
    /// returns the param if the countdown timer is -, otherwise 0
    /// everyt time it executes the countdown timer is decreased
    /// - Returns: true if the instruction finished executing
    func exec(program: CommProgram) -> Bool {
        if !executed {
            countdown -= 1
            if countdown > 0{
                print("within cycle, no execution")
            } else {
                switch cmd {
                case .noop:
                    print("executing noop")
                case .addx:
                    program.registerX += param!
                    print("executed addx with \(param!), register = \(program.registerX)")
                    
                }
                executed = true
            }
        }
        return executed
    }
}

class CommProgram {
    var registerX: Int = 1// the register
    var timer: Int = 0
    var program : [CommInstruction]
    var instructionQueue = [CommInstruction]()
    var currentInstruction : CommInstruction? // pffft, wrong thinking, didn't need this one at all
    let duringExecution : (Int, Int) -> () // jeez, during execution does not mean after execution! That was kinda mean!
    
 
    init(program: [CommInstruction], afterExecution: @escaping (Int, Int) -> Void) {
        self.program = program
        self.duringExecution = afterExecution
    }
    
    func run(end: Int) {
//        while !program.isEmpty || !instructionQueue.isEmpty {
        while timer < end {
            timer += 1
            print("cycle: \(timer)")
            // remove instruction from programQueue and add it to the commandQueue
            if !program.isEmpty  && currentInstruction == nil {
                let instruction = program.removeFirst()
                currentInstruction = instruction
            }
            duringExecution(registerX, timer)
            if let inst = currentInstruction {
                let executed = inst.exec(program: self)
                if executed  { currentInstruction = nil }
            }
            // call the closure declared in the tests
        }
    }
    
    // this one process instructions parallely in a queue, wrong thinking.
    func runWithInstructionQueue(end: Int) {
        while timer < end {
            timer += 1
            print("cycle: \(timer)")
            // remove instruction from programQueue and add it to the commandQueue
            if !program.isEmpty {
                let instruction = program.removeFirst()
                instructionQueue.append(instruction)
            }
            executeInstructionQueue()
            duringExecution(registerX, timer)
        }
    }
    
    // not needed
    fileprivate func executeInstructionQueue() {
        // execute 1 cycle in all commands in the queue
        for inst in instructionQueue {
            let res = inst.exec(program: self)
            print(res)
        }
    }
    
}

class CRT {
    let lineLength = 40
    var picture = ""
    
    func draw(cycle: Int, x: Int) {
        // draw litPixel
        let pixelPos = (cycle-1) % 40
        if x == pixelPos || x == pixelPos - 1 || x == pixelPos + 1 {
            picture.append("#")
        } else {
            picture.append(" ")
        }
        if pixelPos == 39 {
            picture.append("\n")
        } // carr return at end of crt line
    }
}


class AoCDay10 {
    func parse(_ input: String) -> [CommInstruction] {
        let lines = input.parseIntoLines()
        // for every cycle of a clock circuit
        var instructions = [CommInstruction]()
        for line in lines {
            let words = line.parseIntoWords()
            let cmd = CommCommand(rawValue: words[0])!
            var param: Int?
            if words.count > 1 {
                param = Int(words[1])
            }
            instructions.append(CommInstruction(cmd: cmd, param: param))
        }
        return instructions
    }
}
