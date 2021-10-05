//
//  MatchingData.swift
//  Parkv2
//
//  Created by Andreas on 10/4/21.
//

import SwiftUI

struct MatchingData: Hashable {
    var id: String
    var pairs: [MatchCard]
    var speed: Double
    var accuracy: Double
   
}
struct MatchCard: Hashable {
    var id: String = UUID().uuidString
    var text: String
    var isShowing: Bool
    var isMatched: Bool
}
