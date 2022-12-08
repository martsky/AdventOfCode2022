//
//  AoCDay4.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 05/12/2022.
//

import Foundation

struct Section {
    let start: Int
    let end: Int
    
    func containsFully(_ section: Section) -> Bool {
        let s1 = start...end
        let s2 = section.start...section.end
        let contains = s1.contains(s2.lowerBound) && s1.contains(s2.upperBound)
        
//        let contains = start >= section.start && end <= section.end
        print("Section(\(start), \(end) contains Section(\(section.start), \(section.end):  \(contains)")
        return contains
    }
    
    func overlaps(_ section: Section) -> Bool {
        let s1 = start...end
        let s2 = section.start...section.end
        return s1.overlaps(s2)
    }
}

class AoCday4 {
    
    func puzzle1(_ input: String, test: ([Section]) -> Bool ) throws -> Int {
        let sections = input.split(separator: "\n") // split into [String] of lines [2-4,6-8]
        print ("sections\(sections)")
        let sectionGroups: [[Section]]  = sections.map {
            let sections: [Section] = $0.split(separator: ",") // split into [2-4][6-8]
                .map {
                    print (" section:\($0)")
                    let start = Int($0.split(separator: "-").first!)!
                    let end = Int($0.split(separator: "-").last!)!
                    return Section(start: start, end: end) // create
                }
            return sections
        } // split into [[Section]]
        let result = sectionGroups.reduce(0) { partialResult, sectionGroup in //count the overlapping results i one sectionGroup
            var countWithin = 0
            if test(sectionGroup) { // compare sections for intersection or containing
                countWithin += 1
            }
            print ("count is \(countWithin)")
            return partialResult + countWithin
        }
        print ("count = \(result)")
        return result
    }
}
