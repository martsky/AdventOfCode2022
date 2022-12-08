//
//  AoCDay8.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 08/12/2022.
//

import Foundation

struct Tree {
    let size: Int
    let row: Int
    let column: Int
}

struct Matrix<T> {
    let rows: Int, columns: Int
    var grid: [T?]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: nil, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> T? {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    /*
       01234
     0 30373
     1 25512
     2 65332
     */
    func above(row: Int, column: Int) -> [T]? {
        guard row > 0 else{ return nil }
        // would love to get this a bit more elegant using functional approach but can't figure out how
        var array = [T]()
        var index = row - 1
        while index >= 0 {
            array.append(self[index, column]!)
            index -= 1
        }
        return array
    }
    
    func below(row: Int, column: Int) -> [T]? {
        guard row < rows-1 else{ return nil }
        var array = [T]()
        for r in row+1...rows-1 {
            array.append(self[r, column]!)
        }
        return array
    }
    
    func left(row: Int, column: Int) -> [T]? {
        guard column > 0 else { return nil }
        // array gotta be reversed because we need to iterate from the specified tree at the center
        return grid[(row * columns...(row * columns + column - 1))].map{$0!}.reversed()
    }
    
    func right(row: Int, column: Int) -> [T]? {
        guard column < columns-1 else { return nil }
        return grid[(row * columns + column + 1...(((row + 1) * columns-1)))].map{$0!}
    }
}


class AocDay8 {
    
    func parse(_ input: String) -> Matrix<Tree> {
        let lines = input.parseIntoLines()
        var forest = Matrix<Tree>(rows: lines.count, columns: lines[0].count)
        for row in 0...lines.count-1 {
            let line = lines[row]
            for col in 0...line.count-1 {
                let tree = Tree(size: Int(line[col])!, row: row, column: col)
                print("\(tree.size)")
                forest[row, col] = tree
            }
            print("\n")
        }
        return forest
    }

    func totalVisibleInteriorTrees (_ forest: Matrix<Tree>) throws -> Int {
        var totalVisibleInteriorTrees = 0
        for row in 1...forest.rows-2 {
            for col in 1...forest.columns-2 {
                let tree = forest[row, col]!
                
                let higherThanCurrentTree : ((Tree) throws -> Bool) = { $0.size >= tree.size}
                let above: [Tree] = try forest.above(row: row, column: col)!.filter(higherThanCurrentTree)
                let left: [Tree] = try forest.left(row: row, column: col)!.filter(higherThanCurrentTree)
                let right: [Tree] = try forest.right(row: row, column: col)!.filter(higherThanCurrentTree)
                let below: [Tree] = try forest.below(row: row, column: col)!.filter(higherThanCurrentTree)
                
                if above.count == 0 || left.count == 0 || right.count == 0 || below.count == 0 {
                    totalVisibleInteriorTrees += 1
                    print("tree[\(row), \(col)] with size\(tree.size) is visible")
                }
            }
        }
        return totalVisibleInteriorTrees
    }
    


    func maxScenicScore (_ forest: Matrix<Tree>) throws -> Int {
        var maxScenicScore = 0
        for row in 0...forest.rows-1 {
            for col in 0...forest.columns-1 {
                let tree = forest[row, col]!
                var stop = false
                // closure to filter the array on the left, right, above and below of the tree for trees that are lower.
                // to determine the scenic view
                let filterScenicView: (Int, Tree) -> Int = { partialResult, t in
                    if stop {
                        return partialResult
                    }
                    if t.size >= tree.size {
                        stop = true
                    }
                    return partialResult + 1
                }
                
                let scenicScoreAbove: Int = forest.above(row: row, column: col)?.reduce(0, filterScenicView) ?? 0
                stop = false
                let scenicScoreBelow: Int = forest.below(row: row, column: col)?.reduce(0, filterScenicView) ?? 0
                stop = false
                let scenicScoreLeft: Int = forest.left(row: row, column: col)?.reduce(0, filterScenicView) ?? 0
                stop = false
                let scenicScoreRight: Int = forest.right(row: row, column: col)?.reduce(0, filterScenicView) ?? 0
                
                let totalScenicScore = scenicScoreLeft * scenicScoreAbove * scenicScoreBelow * scenicScoreRight
                
                // we are only interested in the maximum
                if totalScenicScore > maxScenicScore {
                    maxScenicScore = totalScenicScore
                }
            }
        }
        return maxScenicScore
    }
    
    

}
