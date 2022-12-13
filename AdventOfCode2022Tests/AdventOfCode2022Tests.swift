//
//  AdventOfCode2022Tests.swift
//  AdventOfCode2022Tests
//
//  Created by Martin Weidner on 03/12/2022.
//

import XCTest

final class AdventOfCode2022Tests: XCTestCase {
    
    private func testForContaining(sectionGroup: [Section]) -> Bool {
        return sectionGroup[0].containsFully(sectionGroup[1]) || sectionGroup[1].containsFully(sectionGroup[0])
    }
    
    private func testForInterSection (sectionGroup: [Section]) -> Bool {
        return sectionGroup[0].overlaps(sectionGroup[1])
    }
    
    
    func testAoc3puzzl1() throws {
        let result = try AoCDay3().puzzle1()
        print (" score is \(result)")
    }
    
    func testAoc3puzzl2() throws {
        let result = try AoCDay3().puzzle2()
        print (" score is \(result)")
    }
    
    func testAoC4puzzle1Example() throws {
        var result = 0
        let input =
        """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""
        result = try AoCday4().puzzle1(input, test: testForContaining)
        XCTAssertEqual(2, result,"result was \(result) but should have been 2")
    }
    
    func testAoC4puzzle1() throws {
        var result = 0
        let input = try Utils.readFile("inputday4")
        result = try AoCday4().puzzle1(input, test: testForContaining)
        print("result is \(result)")
        XCTAssertEqual(433, result,"result was \(result) but should have been 433")
    }
    
    func testAoC4puzzle2Example() throws {
        var result = 0
        let input =
        """
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
        """
        result = try AoCday4().puzzle1(input, test: testForInterSection)
        XCTAssertEqual(4, result,"result was \(result) but should have been 2")
    }
    
    func testAoC4puzzle2() throws {
        var result = 0
        let input = try Utils.readFile("inputday4")
        result = try AoCday4().puzzle1(input, test: testForInterSection)
        print("result is \(result)")
        XCTAssertEqual(852, result,"result was \(result) but should have been 433")
    }
    /*
     [D]
     [N] [C]
     [Z] [M] [P]
     1   2   3
     
     move 1 from 2 to 1
     move 3 from 1 to 3
     move 2 from 2 to 1
     move 1 from 1 to 2
     */
    func testAoC5puzzle1Example() throws {
        let aoc = AoCDay5()
        var result = ""
        let input = try Utils.readFile("inputday5example")
        
        let (configuration, instructions) = aoc.parseIntoParts(lines: input)
        XCTAssertEqual(3, configuration.numOfStacks, "number of stacks wrong")
        XCTAssertEqual("N", configuration.stacks[0]!.peek())
        XCTAssertEqual("D", configuration.stacks[1]!.peek())
        XCTAssertEqual("P", configuration.stacks[2]!.peek())
        XCTAssertNil(configuration.stacks[3], " there should not be a third stack")
        print("\(configuration)")
        //        XCTAssertEqual("CMZ", "result was \(result) but should have been CMZ")
        
        // check amount
        XCTAssertEqual(1, instructions.instructions[0].amount, "amount not correctly parsed in instructions")
        XCTAssertEqual(3, instructions.instructions[1].amount, "amount not correctly parsed in instructions")
        XCTAssertEqual(2, instructions.instructions[2].amount, "amount not correctly parsed in instructions")
        XCTAssertEqual(1, instructions.instructions[3].amount, "amount not correctly parsed in instructions")
        // check fromStack
        XCTAssertEqual(1, instructions.instructions[0].fromStack, "fromStack not correctly parsed in instructions")
        XCTAssertEqual(0, instructions.instructions[1].fromStack, "fromStack not correctly parsed in instructions")
        XCTAssertEqual(1, instructions.instructions[2].fromStack, "fromStack not correctly parsed in instructions")
        XCTAssertEqual(0, instructions.instructions[3].fromStack, "fromStack not correctly parsed in instructions")
        // check toStack
        XCTAssertEqual(0, instructions.instructions[0].toStack, "toStack not correctly parsed in instructions")
        XCTAssertEqual(2, instructions.instructions[1].toStack, "toStack not correctly parsed in instructions")
        XCTAssertEqual(0, instructions.instructions[2].toStack, "toStack not correctly parsed in instructions")
        XCTAssertEqual(1, instructions.instructions[3].toStack, "toStack not correctly parsed in instructions")
        
        // now process the instructions
        configuration.execute1(instructions)
        result = configuration.getTopCrates()
        XCTAssertEqual("CMZ", result, "configuration error")
        
        
        print ("result is:\n\(result)")
    }
    
    func testAoC5puzzle1() throws {
        let aoc = AoCDay5()
        var result = ""
        let input = try Utils.readFile("inputday5")
        let (configuration, instructions) = aoc.parseIntoParts(lines: input)
        configuration.execute1(instructions)
        result = configuration.getTopCrates()
        //        XCTAssertEqual("CMZ", result, "configuration error")
        print ("result is:\n\(result)")
    }
    
    func testAoC5puzzle2Example() throws {
        let aoc = AoCDay5()
        var result = ""
        let input = try Utils.readFile("inputday5example")
        let (configuration, instructions) = aoc.parseIntoParts(lines: input)
        configuration.execute2(instructions)
        result = configuration.getTopCrates()
        XCTAssertEqual("MCD", result, "configuration error")
        print ("result is:\n\(result)")
    }
    
    func testAoC5puzzle2() throws {
        let aoc = AoCDay5()
        var result = ""
        let input = try Utils.readFile("inputday5")
        let (configuration, instructions) = aoc.parseIntoParts(lines: input)
        configuration.execute2(instructions)
        result = configuration.getTopCrates()
        //        XCTAssertEqual("MCD", result, "configuration error")
        print ("result is:\n\(result)")
    }
    
    func testAoCDay6Example() throws {
        let aoc = AoCDay6()
        let exampleinput = ["mjqjpqmgbljsphdztnvjfqwrcgsmlb": 7, "bvwbjplbgvbhsrlpgdmjqwftvncz": 5, "nppdvjthqldpwncqszvftbrmjlhg": 6, "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg": 10, "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw": 11]
        for example in exampleinput.keys {
            let result = aoc.process(example, markerLength: 4)
            print ("result \(String(describing: result?.description))")
            XCTAssertEqual(exampleinput[example], result)
        }
    }
    
    func testAoCDay6Puzzle1() throws {
        let aoc = AoCDay6()
        let exampleinput = try Utils.readFile("inputday6")
        let result = aoc.process(exampleinput, markerLength: 4)
        print ("result \(String(describing: result?.description))")
    }
    
    func testAoCDay6Puzzle2() throws {
        let aoc = AoCDay6()
        let exampleinput = try Utils.readFile("inputday6")
        let result = aoc.process(exampleinput, markerLength: 14)
        print ("result \(String(describing: result?.description))")
    }
    
    func testAoCDay7Example1() throws {
        let maxSize = 100000
        let root = Dir(name: "/", parent: nil)
        let aoc = AoCDay7(currentDir: root)
        let input = try Utils.readFile("inputday7example")
        // parse into a structure that contains the right hierarchy
        aoc.parse(input)
        var totalSize = 0
        root.visitAllDirs { fsItem in // add the size of all directories bigger than maxSize
            if fsItem.type == .dir && fsItem.size < maxSize {
                totalSize += fsItem.size
            }
        }
        XCTAssertEqual(95437, totalSize)
    }
    
    func testAoCDay7Puzzle1() throws {
        let maxSize = 100000
        let root = Dir(name: "/", parent: nil)
        let aoc = AoCDay7(currentDir: root)
        let input = try Utils.readFile("inputday7")
        // parse into a structure that contains the right hierarchy
        aoc.parse(input)
        var totalSize = 0
        root.visitAllDirs { fsItem in
            if fsItem.type == .dir && fsItem.size < maxSize {
                totalSize += fsItem.size
            }
        }
        print("totalSize =\(totalSize)")
        XCTAssertEqual(1844187, totalSize)
    }
    
    func testAoCDay7ExamplePuzzle2() throws {
        let totalDiskSpace = 70000000
        let spaceNeeded = 30000000
        let root = Dir(name: "/", parent: nil)
        let aoc = AoCDay7(currentDir: root)
        let input = try Utils.readFile("inputday7example")
        // parse into a structure that contains the right hierarchy
        aoc.parse(input)
        let usedSpace = root.size
        let spaceFree = totalDiskSpace - usedSpace
        let extraSpaceNeeded = spaceNeeded - spaceFree
        
        // find the smallest directory that is bigger than the extraSpaceNeeded
        var smallestSpaceNeeded = 0
        root.visitAllDirs { fsItem in
            if fsItem.type == .dir && fsItem.size > extraSpaceNeeded {
                if smallestSpaceNeeded == 0 {
                    smallestSpaceNeeded = fsItem.size
                } else {
                    if fsItem.size < smallestSpaceNeeded {
                        smallestSpaceNeeded = fsItem.size
                    }
                }
            }
        }
        print ("smallest directorysize needed: \(smallestSpaceNeeded)")
        XCTAssertEqual(24933642, smallestSpaceNeeded)
    }
    
    func testAoCDay7Puzzle2() throws {
        let totalDiskSpace = 70000000
        let spaceNeeded = 30000000
        let root = Dir(name: "/", parent: nil)
        let aoc = AoCDay7(currentDir: root)
        let input = try Utils.readFile("inputday7")
        // parse into a structure that contains the right hierarchy
        aoc.parse(input)
        let usedSpace = root.size
        let spaceFree = totalDiskSpace - usedSpace
        let extraSpaceNeeded = spaceNeeded - spaceFree
        
        // find the smallest directory that is bigger than the extraSpaceNeeded
        var smallestSpaceNeeded = 0
        root.visitAllDirs { fsItem in
            if fsItem.type == .dir && fsItem.size > extraSpaceNeeded {
                if smallestSpaceNeeded == 0 {
                    smallestSpaceNeeded = fsItem.size
                } else {
                    if fsItem.size < smallestSpaceNeeded {
                        smallestSpaceNeeded = fsItem.size
                    }
                }
            }
        }
        print ("smallest directorysize needed: \(smallestSpaceNeeded)")
        XCTAssertEqual(4978279, smallestSpaceNeeded)
    }
    
    
    /*
     30373
     25512
     65332
     33549
     35390
     
     visible if item [x,y] is visible if [x-1,y], [x+1,y] [x, y-1] and [x,y+1] < [x,y].size
     */
    func testDay81Example() throws {
        let input = try Utils.readFile("inputday8example")
        let aoc = AocDay8()
        let forest = aoc.parse(input)
        XCTAssertEqual(5, forest.rows)
        XCTAssertEqual(5, forest.columns)
        XCTAssertEqual(3, forest[0,0]?.size)
        XCTAssertEqual(5, forest[1,1]?.size)
        XCTAssertEqual(3, forest[2,2]?.size)
        XCTAssertEqual(4, forest[3,3]?.size)
        XCTAssertEqual(0, forest[4,4]?.size)
        
        let totalVisibleInteriorTrees = try aoc.totalVisibleInteriorTrees(forest)
        print("total visible trees:\(totalVisibleInteriorTrees)")
        XCTAssertEqual(5, totalVisibleInteriorTrees)
        let total = totalVisibleInteriorTrees + (forest.rows * 2) + ((forest.columns * 2)-4)
        XCTAssertEqual(21, total)
    }
    
    func testDay81Example2() throws {
        let input =
        """
        888
        818
        888
        """
        let aoc = AocDay8()
        let forest = aoc.parse(input)
        let totalVisibleInteriorTrees = try aoc.totalVisibleInteriorTrees(forest)
        print("total visible trees:\(totalVisibleInteriorTrees)")
        XCTAssertEqual(0, totalVisibleInteriorTrees)
    }
    
    func testDay81() throws {
        let input = try Utils.readFile("inputday8")
        let aoc = AocDay8()
        let forest = aoc.parse(input)
        let totalVisibleInteriorTrees = try aoc.totalVisibleInteriorTrees(forest)
        // add all the exterior trees.
        let total = totalVisibleInteriorTrees + (forest.rows * 2) + ((forest.columns * 2)-4)
        print("total visible trees:\(total)")
    }
    
    func testDay82Example() throws {
        let input = try Utils.readFile("inputday8example")
        let aoc = AocDay8()
        let forest = aoc.parse(input)
        let score = try aoc.maxScenicScore(forest)
        XCTAssertEqual(8, score)
        print("max scenic score is:\(score)")
    }
    
    func testDay82() throws {
        let input = try Utils.readFile("inputday8")
        let aoc = AocDay8()
        let forest = aoc.parse(input)
        let score = try aoc.maxScenicScore(forest)
        print("max scenic score is:\(score)")
        XCTAssertEqual(287040, score)
    }
    
    func testDay9InputParsing() throws {
        let input = try Utils.readFile("inputday9example")
        let aoc = AoCDay9()
        //parse the input into a program containing a series of commands
        let commands = aoc.parse(input)
        XCTAssertEqual(commands[0].0, .Right)
        XCTAssertEqual(commands[0].1, 4)
        XCTAssertEqual(commands[1].0, .Up)
        XCTAssertEqual(commands[1].1, 4)
        XCTAssertEqual(commands[2].0, .Left)
        XCTAssertEqual(commands[2].1, 3)
    }
    
    /// We are playing Snake!
    func testDay9BasicMovement() throws {
        let head = Head()
        let tail = Tail()
        
        var tailPos = tail.curPos()
        var headPos = head.move(cmd: .Up)
        
        XCTAssertEqual(headPos.x, 0)
        XCTAssertEqual(headPos.y, 1)
        if let tailCmd = tail.calcCommand(headPosition: headPos) {
            tailPos = tail.move(cmd: tailCmd)
        }
        // head moved up
        // tail did not move
        XCTAssertEqual(tailPos.x, 0)
        XCTAssertEqual(tailPos.y, 0)
        headPos = head.move(cmd: .Up)
        // head moved up
        XCTAssertEqual(headPos.x, 0)
        XCTAssertEqual(headPos.y, 2)
        if let tailCmd = tail.calcCommand(headPosition: headPos) {
            XCTAssertEqual(tailCmd, .Up)
            tailPos = tail.move(cmd: tailCmd)
        }
        // tail moved up 1
        XCTAssertEqual(tailPos.x, 0)
        XCTAssertEqual(tailPos.y, 1)
        XCTAssertTrue(tail.visited.contains(Position(0,0)))
        XCTAssertTrue(tail.visited.contains(Position(0,1)))
        XCTAssertEqual(2, tail.visited.count)
        
        
        // head moved right
        headPos = head.move(cmd: .Right)
        XCTAssertEqual(headPos.x, 1)
        XCTAssertEqual(headPos.y, 2)
        if let tailCmd = tail.calcCommand(headPosition: headPos) {
            tailPos = tail.move(cmd: tailCmd)
        }
        // tail stayed the same
        XCTAssertEqual(tailPos.x, 0)
        XCTAssertEqual(tailPos.y, 1)
        // head moved right
        headPos = head.move(cmd: .Right)
        XCTAssertEqual(headPos.x, 2)
        XCTAssertEqual(headPos.y, 2)
        if let tailCmd = tail.calcCommand(headPosition: headPos) {
            XCTAssertEqual(.UpRight, tailCmd)
            tailPos = tail.move(cmd: tailCmd)
        }
        // tail moved diagonally
        XCTAssertEqual(tailPos.x, 1)
        XCTAssertEqual(tailPos.y, 2)
        // head moved left
        headPos = head.move(cmd: .Left)
        XCTAssertEqual(headPos.x, 1)
        XCTAssertEqual(headPos.y, 2)
        if let tailCmd = tail.calcCommand(headPosition: headPos) {
            tailPos = tail.move(cmd: tailCmd)
        }
        // tail stayed the same
        XCTAssertEqual(tailPos.x, 1)
        XCTAssertEqual(tailPos.y, 2)
        // head moved left
        headPos = head.move(cmd: .Left)
        XCTAssertEqual(headPos.x, 0)
        XCTAssertEqual(headPos.y, 2)
        if let tailCmd = tail.calcCommand(headPosition: headPos) {
            tailPos = tail.move(cmd: tailCmd)
        }
        // tail stayed the same
        XCTAssertEqual(tailPos.x, 1)
        XCTAssertEqual(tailPos.y, 2)
        
        // let's build us a snake containing of a head and a tail. That's much nicer.
        // now we move the whole snake to the left
        let body = [tail]
        var snake = Snake(head: head, body: body)
        snake = snake.move(cmd: .Left)
        headPos = snake.head.curPos()
        tailPos = snake.tail().curPos()
        XCTAssertEqual(headPos.x,-1)
        XCTAssertEqual(headPos.y, 2)
        XCTAssertEqual(tailPos.x, 0)
        XCTAssertEqual(tailPos.y, 2)
        
        // move3 times down
        snake = snake.move(cmd: .Down).move(cmd: .Down).move(cmd: .Down)
        headPos = snake.head.curPos()
        tailPos = snake.tail().curPos()
        XCTAssertEqual(headPos.x,-1)
        XCTAssertEqual(headPos.y,-1)
        XCTAssertEqual(tailPos.x, -1)
        XCTAssertEqual(tailPos.y, 0)
        
    }
    
    func testDay9Example() throws {
        let input = try Utils.readFile("inputday9example")
        let aoc = AoCDay9()
        //parse the input into a program containing a series of commands
        let commands = aoc.parse(input)
        //move the head in an (infinite) matrix
        let head = Head()
        let body = [Tail()]
        var snake = Snake(head: head, body: body)
        for command in commands {
            let (cmd, steps) = command
            print("moving \(cmd) for \(steps)")
            for _ in 0..<steps {
                snake = snake.move(cmd: cmd)
                print("moved ")
            }
        }
        XCTAssertEqual(13, snake.tail().visited.count)
    }
    
    func testDay91() throws {
        let input = try Utils.readFile("inputday9")
        let aoc = AoCDay9()
        let commands = aoc.parse(input)
        let head = Head()
        let body = [Tail()]
        var snake = Snake(head: head, body: body)
        for command in commands {
            let (cmd, steps) = command
            print("moving \(cmd) for \(steps)")
            for _ in 0..<steps {
                snake = snake.move(cmd: cmd)
                print("moved ")
            }
        }
        print("visited: \(snake.tail().visited.count)")
        XCTAssertEqual(6464, snake.tail().visited.count)
    }
    
    func testDay92Example() throws {
        let input = try Utils.readFile("inputday9example2")
        let aoc = AoCDay9()
        let commands = aoc.parse(input)
        let head = Head()
        let body = [Tail(), Tail(), Tail(), Tail(), Tail(), Tail(), Tail(), Tail(), Tail()]
        var snake = Snake(head: head, body: body)
        for command in commands {
            let (cmd, steps) = command
            print("moving \(cmd) for \(steps)")
            for _ in 0..<steps {
                snake = snake.move(cmd: cmd)
                print("moved ")
            }
        }
        print("visited: \(snake.tail().visited.count)")
        XCTAssertEqual(36, snake.tail().visited.count)
    }
    
    func testDay92() throws {
        let input = try Utils.readFile("inputday9")
        let aoc = AoCDay9()
        let commands = aoc.parse(input)
        let head = Head()
        let body = [Tail(), Tail(), Tail(), Tail(), Tail(), Tail(), Tail(), Tail(), Tail()]
        var snake = Snake(head: head, body: body)
        for command in commands {
            let (cmd, steps) = command
            print("moving \(cmd) for \(steps)")
            for _ in 0..<steps {
                snake = snake.move(cmd: cmd)
                print("moved ")
            }
        }
        print("visited: \(snake.tail().visited.count)")
        XCTAssertEqual(2604, snake.tail().visited.count)
    }
    
    func testDay10SimpleExample() throws {
        let input =
        """
        noop
        addx 3
        addx -5
        """
        let aoc = AoCDay10()
        let instructions = aoc.parse(input)
        var signalStrength = 0
        let testCycles = [5]
        let program = CommProgram(program: instructions) { registerX, timer in
            print("x = \(registerX)")
            if testCycles.contains(timer) {
                signalStrength += timer * registerX
                print("testing signal: x = \(registerX), timer = \(timer), strength = \(signalStrength)")
                XCTAssertEqual(5, timer)
                XCTAssertEqual(4, registerX)
            }
        }
        program.run(end: 5) // run for X cycles
        XCTAssertEqual(20, signalStrength)
        print ("signalStrength: \(signalStrength)")
    }
    
    func testDay10ComplexExample() throws {
        let input = try Utils.readFile("inputday10example")
        let aoc = AoCDay10()
        let instructions = aoc.parse(input)
        var signalStrength = 0
        let testCycles = [20,60,100,140,180,220]
        let program = CommProgram(program: instructions) { registerX, timer in
            print("x = \(registerX)")
            if testCycles.contains(timer) {
                signalStrength += timer * registerX
                print("testing signal: x = \(registerX), timer = \(timer), strength = \(signalStrength)")
            }
        }
        program.run(end: 220) // run for X cycles
        print ("signalStrength: \(signalStrength)")
        XCTAssertEqual(13140, signalStrength)
    }
    
    func testDay10Puzzle1() throws {
        let input = try Utils.readFile("inputday10")
        let aoc = AoCDay10()
        let instructions = aoc.parse(input)
        var signalStrength = 0
        let testCycles = [20,60,100,140,180,220]
        let program = CommProgram(program: instructions) { registerX, timer in
            if testCycles.contains(timer) {
                signalStrength += timer * registerX
                print("testing signal: x = \(registerX), timer = \(timer), strength = \(signalStrength)")
            }
        }
        program.run(end: 220) // run for X cycles
        print ("signalStrength: \(signalStrength)")
    }
    
    func testDay10Puzzle2ComplexExample() throws {
        let input = try Utils.readFile("inputday10example")
        let aoc = AoCDay10()
        let instructions = aoc.parse(input)
        let crt = CRT()
        let program = CommProgram(program: instructions) { registerX, timer in
            print("signal: x = \(registerX), timer = \(timer)")
            crt.draw(cycle: timer, x: registerX)
        }
        program.run(end: 240) // run for X cycles
        print(crt.picture)
    }
    
    func testDay10Puzzle2() throws {
        let input = try Utils.readFile("inputday10")
        let aoc = AoCDay10()
        let instructions = aoc.parse(input)
        let crt = CRT()
        let program = CommProgram(program: instructions) { registerX, timer in
            print("signal: x = \(registerX), timer = \(timer)")
            crt.draw(cycle: timer, x: registerX)
        }
        program.run(end: 240) // run for X cycles
        print(crt.picture)
    }
    
    func testDay11ParssingMonkeys() throws {
        // parse input to monkeys
        let lines = try Utils.readFile("inputday11example").parseIntoLines()
        let game = KeepAwayGame()
        game.parse(lines: lines)
        let monkeys = game.monkeys
        XCTAssertEqual(79, monkeys[0]!.items[0])
        XCTAssertEqual(98, monkeys[0]!.items[1])
        XCTAssertEqual(Operator.multOp, monkeys[0]!.operation.op)
        XCTAssertEqual(19, monkeys[0]!.operation.operand)
        XCTAssertEqual(23, monkeys[0]!.testDivisible)
        XCTAssertEqual(2, monkeys[0]!.outcome[true])
        XCTAssertEqual(3, monkeys[0]!.outcome[false])
    }
    
    func testDay11Puzzle1Example1() throws {
        // parse input to monkeys
        let lines = try Utils.readFile("inputday11example").parseIntoLines()
        // parse into dictionary, the key is the identifier of the monkey
        let game = KeepAwayGame()
        game.parse(lines: lines)
        let monkeys = game.monkeys
        //let's play the game
        for i in 0...19 { // 20 rounds
            for id in monkeys.keys.sorted() {
                let monkey = monkeys[id]!
                game.inspectItems(monkey: monkey) { worryLevel in
                    return Int(round(Float(worryLevel / 3)))
                }
            }
            if i == 0 {
                XCTAssertEqual(20, monkeys[0]?.items[0])
                XCTAssertEqual(23, monkeys[0]?.items[1])
                XCTAssertEqual(27, monkeys[0]?.items[2])
                XCTAssertEqual(26, monkeys[0]?.items[3])
                XCTAssertEqual(2080, monkeys[1]?.items[0])
                XCTAssertEqual(25, monkeys[1]?.items[1])
                XCTAssertEqual(167, monkeys[1]?.items[2])
                XCTAssertEqual(207, monkeys[1]?.items[3])
                XCTAssertEqual(401, monkeys[1]?.items[4])
                XCTAssertEqual(1046, monkeys[1]?.items[5])
                XCTAssertEqual(0, monkeys[2]?.items.count)
                XCTAssertEqual(0, monkeys[3]?.items.count)
                
            }
        }
        XCTAssertEqual(101, monkeys[0]!.inspected)
        XCTAssertEqual(95, monkeys[1]!.inspected)
        XCTAssertEqual(7, monkeys[2]!.inspected)
        XCTAssertEqual(105, monkeys[3]!.inspected)
        let sortedMonkeyLevels:[Int] = monkeys.values.map { $0.inspected }.sorted()
        let monkeyBusinessLevel = sortedMonkeyLevels[sortedMonkeyLevels.count-1] * sortedMonkeyLevels[sortedMonkeyLevels.count-2]
        XCTAssertEqual(10605, monkeyBusinessLevel)
    }
    
    func testDay11Puzzle1() throws {
        // parse input to monkeys
        let lines = try Utils.readFile("inputday11").parseIntoLines()
        // parse into dictionary, the key is the identifier of the monkey
        let game = KeepAwayGame()
        game.parse(lines: lines)
        let monkeys = game.monkeys
        //let's play the game
        for _ in 0...19 { // 20 rounds
            for id in monkeys.keys.sorted() {
                let monkey = monkeys[id]!
                game.inspectItems(monkey: monkey) { worryLevel in
                    return Int(round(Float(worryLevel / 3)))
                }
            }
        }
        let sortedMonkeyLevels:[Int] = monkeys.values.map { $0.inspected }.sorted()
        let monkeyBusinessLevel = sortedMonkeyLevels[sortedMonkeyLevels.count-1] * sortedMonkeyLevels[sortedMonkeyLevels.count-2]
        print("monkeyBusinessLevel = \(monkeyBusinessLevel)")
        XCTAssertEqual(110888, monkeyBusinessLevel)
    }
 
    
    func testDay11Puzzle2() throws {
        // parse input to monkeys
        let lines = try Utils.readFile("inputday11").parseIntoLines()
        // parse into dictionary, the key is the identifier of the monkey
        let game = KeepAwayGame()
        game.parse(lines: lines)
        let monkeys = game.monkeys
        //let's play the game
        for _ in 0...19 { // 20 rounds
            for id in monkeys.keys.sorted() {
                let monkey = monkeys[id]!
                game.inspectItems(monkey: monkey) { $0 } ///pffft now i need some math knowledge. how do i avoid the arithmetic overflow
            }
        }
        let sortedMonkeyLevels:[Int] = monkeys.values.map { $0.inspected }.sorted()
        let monkeyBusinessLevel = sortedMonkeyLevels[sortedMonkeyLevels.count-1] * sortedMonkeyLevels[sortedMonkeyLevels.count-2]
        print("monkeyBusinessLevel = \(monkeyBusinessLevel)")
        XCTAssertEqual(110888, monkeyBusinessLevel)
    }
    
}
