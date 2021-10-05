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
struct BlueStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.custom("Montserrat-SemiBold", size: 15, relativeTo: .subheadline))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.Primary)
            .background(Color(.white))
        //.background(configuration.isPressed ? Color.buttonPressedBlue:Color.buttonBlue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
//            .shadow(color:Color(.white).opacity(0.3), radius: 10)
//            .shadow(color: Color(.white).opacity(configuration.isPressed ? 0 : 0.6), radius: 3, x: 3, y: 3)
        //.animation(.default)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.easeOut(duration: 0.2))
        
    }
}
