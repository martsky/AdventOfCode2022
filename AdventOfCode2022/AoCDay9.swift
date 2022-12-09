//
//  AoCDay9.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 09/12/2022.
//

import Foundation

enum Command: String {
    case Up = "U"
    case Down = "D"
    case Left = "L"
    case Right = "R"
    case UpRight = "UR"
    case UpLeft = "UL"
    case DownRight = "DR"
    case DownLeft = "DL"
}

struct Position: Hashable, Equatable {
    let x: Int
    let y: Int
    
    init(_ x: Int,_ y: Int) {
        self.x = x
        self.y = y
    }
}

class SnakePart {
    var moves = [Position]()
    var visited = Set<Position>() // dictionary to keep a list of unique visited places([0,0][1,0][1,1])
    
    func move(cmd: Command) -> Position {
        let currentPos = curPos()
        var newPos: Position
        switch cmd {
        case .Up:
            newPos = Position(currentPos.x, currentPos.y + 1)
        case .Down:
            newPos = Position(currentPos.x, currentPos.y - 1)
        case .Left:
            newPos = Position(currentPos.x - 1, currentPos.y)
        case .Right:
            newPos = Position(currentPos.x + 1, currentPos.y)
        case .UpRight:
            newPos = Position(currentPos.x + 1, currentPos.y + 1)
        case .UpLeft:
            newPos = Position(currentPos.x - 1, currentPos.y + 1)
        case .DownRight:
            newPos = Position(currentPos.x + 1, currentPos.y - 1)
        case .DownLeft:
            newPos = Position(currentPos.x - 1, currentPos.y - 1)
        }
        moves.append(newPos)
        visited.insert(newPos)
        return newPos
    }
    
    func curPos() -> Position {
        return moves.last!
    }
    
    init() {
        self.moves.append(Position(0,0))
        self.visited.insert(moves.last!)
    }
}

struct Snake  {
    let head: Head
    let tail: Tail
    
    func move(cmd: Command) -> Snake{
        let headPos = head.move(cmd: cmd)
        print("head(\(headPos))")
        if let tailCmd = tail.calcCommand(headPosition: headPos) {
            let tailPos = tail.move(cmd: tailCmd)
            print("tail(\(tailPos))")

        }
        return self
    }
}

class Head: SnakePart {
    
}

class Tail: SnakePart {
    
    func calcCommand(headPosition: Position) -> Command? {
        // if head is adjacent to tail or overlaps we don't move at all
        let curPos = curPos()
        let diffx = headPosition.x - curPos.x
        let diffy = headPosition.y - curPos.y
        if (0...1).contains(abs(diffy)) && (0...1).contains(abs(diffx)) {
            return nil
        }
        
        // if head is 2 steps right of tail
        if (diffx == 0 && diffy == 2) {
            return .Up
        }
        // if head is 2 steps left of tail
        if (diffx == 0 && diffy == -2)  {
            return .Down
        }
        // if head is 2 steps up of tail
        if (diffx == 2 && diffy == 0)  {
            return .Right
        }
        // if head is 2 steps up of tail
        if (diffx == -2 && diffy == 0)  {
            return .Left
        }
        
        // if the head and tail aren't adjacent and in the same row or column, the tail always moves one step diagonally
        //let diffx = headPosition.x - curPos.x ==> if >0 T..H if <0 H..T
        //let diffy = headPosition.y - curPos.y==> if >0 H is up from T, if <0 H is down from T
        if (diffx <= -2 && diffy >= 1) || (diffx <= -1 && diffy >= 2) { //head is somwhere upright
            return .UpLeft
        }
        if (diffx <= -2 && diffy <= -1) || (diffx <= -1 && diffy <= -2) { //head is somwhere downright
            return .DownLeft
        }
        if (diffx >= 2 && diffy <= -1) || (diffx >= 1 && diffy <= -2) { //head is somwhere downright
            return .DownRight
        }
        if (diffx >= 2 && diffy >= 1) || (diffx >= 1 && diffy >= 2) { //head is somwhere upright
            return .UpRight
        }
        return nil
    }
}


class AoCDay9 {
    
    func parse(_ input: String) -> [(Command, Int)] {
        let lines = input.parseIntoLines()
        var commands = [(Command, Int)]()
        for line in lines {
            let chars = line.split(separator: " ").map{String($0)}
            commands.append((Command(rawValue: chars[0])!, Int(chars[1])!))
        }
        return commands
    }
}
