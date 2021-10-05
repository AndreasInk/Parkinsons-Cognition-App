//
//  MatchingButtonStyle.swift
//  Parkv2
//
//  Created by Andreas on 10/5/21.
//

import SwiftUI


struct MatchingButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
          
               
        configuration.label
            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            .foregroundColor(Color(.white))
            .padding()
           
           
           
            //.animation(.easeOut(duration: 0.2))
    }   .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .frame(height: 85)
            .padding()
        
    }
}
