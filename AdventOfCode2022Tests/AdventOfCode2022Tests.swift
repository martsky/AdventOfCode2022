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
}
