//
//  ContentView.swift
//  AdventOfCode2022
//
//  Created by Martin Weidner on 03/12/2022.
//

import SwiftUI

struct ContentView: View {
    var aoc = AoCDay3()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello Advent Of Code")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
