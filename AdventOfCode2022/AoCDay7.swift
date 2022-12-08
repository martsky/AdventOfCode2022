//
//  AoCDay7.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 07/12/2022.
//

import Foundation

enum FSType {
    case dir
    case file
}

class FSItem {
    let name: String
    let type: FSType
    var size: Int { return 0 }
    init(name: String, type: FSType) {
        self.name = name
        self.type = type
    }
}

class File: FSItem {
    let fileSize: Int
    override var size: Int { return fileSize }
    init(name: String,  fileSize: Int) {
        self.fileSize = fileSize
        super.init(name: name, type: .file)
    }
    

}

class Dir: FSItem {
    let parent: Dir?
    var subItems = [String: FSItem]()
    override var size: Int {
        return self.subItems.values.reduce(0) { partialResult, sub in
            partialResult + sub.self.size
        }
    }
    
    init(name: String, parent: Dir?) {
        self.parent = parent
        super.init(name: name, type: .dir)
    }
    
    func addSub(_ fsItem:FSItem) {
        self.subItems[fsItem.name] = fsItem
    }
    
    func visitAllDirs(process: (FSItem) -> ()) {
        for item in subItems.values {
            process(item)
            if item.type == .dir {
                let dir = item as! Dir
                dir.visitAllDirs(process: process)
            }
        }
    }
}

class AoCDay7 {
    var currentDir: Dir
    
    init(currentDir: Dir) {
        self.currentDir = currentDir
    }
    
    fileprivate func processCommand(_ words: [String]) {
        for var i in 0...words.count-1 {
            switch words[i] {
            case "cd": // switch into subdirectory, the next word is the name of the directory
                print("cd")
                i += 1 // the next word contains the name of the directory
                if words[i] == ".." { // we switch to the parent directory
                    currentDir = currentDir.parent!
                } else { // switch to a subdirectory
                    guard let newDir = currentDir.subItems[words[i]], newDir.type == .dir else {
                        fatalError("cd to \(words[i]) not possible")
                    }
                    currentDir = newDir as! Dir
                    break
                }
            default:
                print("command: \(words[i])")
            }
                
        }
    }
    
    fileprivate func processContents(_ words: [String]) {
        if words[0] == "dir" { // content starts with either the keyword "dir" or a number (the size of a file)  followed by a name
            currentDir.subItems[words[1]] = Dir(name: words[1], parent: currentDir)
        } else {
            currentDir.subItems[words[1]] = File(name: words[1], fileSize: Int(words[0])!)
        }
    }
    
    func parse(_ input: String) {
        let lines: [String] = input.parseIntoLines().dropFirst().map {String($0)}// parse into lines, the first line is $ cd / and we already know what to do
        for line in lines {
            let words: [String] = line.split(separator: " ").map { String($0) }
            switch words[0] {
            case "$": // process command
                processCommand(words)
            default: // process directory content
                processContents(words)
            }
        }
    }
}
