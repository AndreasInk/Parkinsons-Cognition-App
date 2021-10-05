//
//  MatchingSuccessCardView.swift
//  Parkv2
//
//  Created by Andreas on 10/5/21.
//

import SwiftUI

struct MatchingSuccessCardView: View {
    @ObservedObject var matchingManager: MatchingManager
    let encouragment = ["Great Work!", "Awesome!", "Nice!"]
    let encouragment2 = ["Great Start!", "You Got This!", "Nice Start!"]
    @State var encouragmentText = "Nice!"
    var body: some View {
        VStack {
            Spacer()
                .onAppear() {
                    encouragmentText = matchingManager.matching.speed < matchingManager.averageSpeed ? encouragment.randomElement() ?? "Nice!" : encouragment2.randomElement() ?? "Nice!"
                }
            Text(encouragmentText)
                .font(.headline)
                .foregroundColor(.Primary)
                .padding()
            Text(String(matchingManager.matching.speed))
                .font(.largeTitle)
                .foregroundColor(.Primary)
                .bold()
                .padding()
            Text("Average: " + String(matchingManager.averageSpeed))
                .font(.caption)
                .foregroundColor(.white)
                .bold()
                .padding()
            Spacer()
            Button(action: {
                matchingManager.randomMatching()
            }) {
                
                Label("Play Again?", systemSymbol: .repeat)
                    .font(.headline)
            }.buttonStyle(BlueStyle())
                .padding(.vertical)
            Button(action: {
                
            }) {
                Label("Return Home?", systemSymbol: .house)
                    .font(.headline)
                
            }.buttonStyle(BlueStyle())
                .padding(.vertical)
            Spacer()
        } .padding()
            .background(Color.Light.clipShape(RoundedRectangle(cornerRadius: 25)).shadow(color: .Light, radius: 5, x: 0, y: 0))
            .frame(maxWidth: 300, maxHeight: 300)
    }
}

