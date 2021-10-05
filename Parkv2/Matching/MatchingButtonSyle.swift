//
//  MatchingButtonSyle.swift
//  Parkv2
//
//  Created by Andreas on 10/5/21.
//

import SwiftUI

struct MatchingButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .rotation3DEffect(.degrees(configuration.isPressed ? 0 : 2), axis: (x: 0, y: 1, z: 0))
         
            .animation(.spring())
    }
}
