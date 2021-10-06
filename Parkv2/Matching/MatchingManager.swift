//
//  MatchingManager.swift
//  Parkv2
//
//  Created by Andreas on 10/4/21.
//

import SwiftUI

class MatchingManager: ObservableObject {
    @Published var matchings = [MatchingData]()
    @Published var matching = MatchingData(id: UUID().uuidString, pairs: [MatchCard(text: "🎉", isShowing: true, isMatched: false), MatchCard(text: "🧠", isShowing: true, isMatched: false), MatchCard(text: "⚡️", isShowing: true, isMatched: false)], speed: -1, accuracy: 0)
    
    @Published var lastText = ""
    @Published var lastID = ""
    
    @Published var time = 10
    
    @Published var averageSpeed = UserDefaults.standard.double(forKey: "averageMatching")
    @Published var speeds: [Double] = UserDefaults.standard.array(forKey: "speeds") as? [Double] ?? []
    
    
    let characters = String().emojis
    
    
    init() {
        for var pair in matching.pairs {
            pair.id = UUID().uuidString
            matching.pairs.append(pair)
        }
        matching.pairs = matching.pairs.shuffled()
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            withAnimation(.spring()) {
            self.time -= 1
            }
            if self.time < 2 {
                if self.matching.speed < 1 && self.matching.speed != -1 {
                    self.toggleAllCards()
                }
                if self.matching.pairs.filter({ card in
                    return card.isMatched
                }).count < 5 {
                   
                    self.matching.speed += 1
                    
                    
                }
            }
        }
    }
    func randomMatching() {
        speeds.append(matching.speed)
        UserDefaults.standard.set(speeds, forKey: "speeds")
        UserDefaults.standard.set(speeds.average, forKey: "averageMatching")
        averageSpeed = UserDefaults.standard.double(forKey: "averageMatching")
        matching = MatchingData(id: UUID().uuidString, pairs: [], speed: -1, accuracy: 0)
      
        for i in 0x1F601...0x1F64F {
            matching.pairs.append(MatchCard(id: UUID().uuidString, text: String(UnicodeScalar(i) ?? "-"), isShowing: true, isMatched: false))
        }
        matching.pairs = matching.pairs.shuffled()
        matching.pairs.removeLast( matching.pairs.count - 3)
        for var pair in matching.pairs {
            pair.id = UUID().uuidString
            matching.pairs.append(pair)
        }
        time = 10
    }
    func toggleAllCards() {
        for i in matching.pairs.indices {
            withAnimation(.easeOut(duration: 1.5)) {
                matching.pairs[i].isShowing.toggle()
            }
            
        }
    }
}
