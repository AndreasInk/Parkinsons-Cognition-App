//
//  MatchingManager.swift
//  Parkv2
//
//  Created by Andreas on 10/4/21.
//

import SwiftUI

class MatchingManager: ObservableObject {
   @Published var matchings = [MatchingData]()
    @Published var matching = MatchingData(id: UUID().uuidString, pairs: [MatchCard(text: "🎉", isShowing: true, isMatched: false), MatchCard(text: "🧠", isShowing: true, isMatched: false), MatchCard(text: "⚡️", isShowing: true, isMatched: false)], speed: 0, accuracy: 0)
   
    @Published var lastText = ""
    @Published var lastID = ""
    
    @Published var time = 10
    
    init() {
        for var pair in matching.pairs {
            pair.id = UUID().uuidString
        matching.pairs.append(pair)
        }
        matching.pairs = matching.pairs.shuffled()
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.time -= 1
            if self.time < 1 {
                self.toggleAllCards()
                timer.invalidate()
            }
        }
    }
    func toggleAllCards() {
        for i in matching.pairs.indices {
            withAnimation(.easeOut(duration: 2.0)) {
            matching.pairs[i].isShowing.toggle()
            }
            
        }
    }
}
