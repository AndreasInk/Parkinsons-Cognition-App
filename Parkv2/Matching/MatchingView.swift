//
//  MatchingView.swift
//  Parkv2
//
//  Created by Andreas on 10/4/21.
//

import SwiftUI
import SFSafeSymbols
struct MatchingView: View {
    @State var gridLayout = [GridItem(.fixed(150), spacing: 10, alignment: .leading),
                             GridItem(.fixed(150), spacing: 10, alignment: .leading)]
    @StateObject var matchingManager = MatchingManager()
    
    @State var confetti = false
    
    @State var done = false
    
    var body: some View {
        ZStack {
            VStack {
             
                    if matchingManager.time > 0 {
                        Text("Time Left To Memorize: " + String(matchingManager.time))
                            .font(.title)
                            .bold()
                            .padding()
                    }
                LazyVGrid(columns: gridLayout, spacing: 5) {
                    ForEach($matchingManager.matching.pairs, id:\.id) { $pair in
                        
                        Button(action: {
                            
                           
                            withAnimation(.easeOut) {
                                if  matchingManager.lastID != pair.id {
                                    pair.isMatched = matchingManager.lastText == pair.text
                                }
                               
                                
                                
                            
                            withAnimation(.easeOut) {
                                pair.isShowing = true
                            }
                                
                               
                            }
                            matchingManager.lastText = pair.text
                            matchingManager.lastID  = pair.id
                            //
                        }) {
                            
                            ZStack {
                                
                                (pair.isMatched ? LinearGradient.Primary : LinearGradient.Light)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape( RoundedRectangle(cornerRadius: 20))
                                
                                
                                
                                if pair.isShowing || pair.isMatched {
                                    Text( pair.text)
                                        .font(.custom( "", size: 48))
                                        .foregroundColor(.white)
                                        .fixedSize()
                                        .transition(.opacity)
                                }
                            }
                        } //.buttonStyle(MatchingButtonStyle())
                        .onChange(of: pair.isShowing) { value in
                           
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                               
                                    if matchingManager.time < 1 {
                                withAnimation(.easeOut(duration: 2.0)) {
                                    
                                    pair.isShowing = false
                                }
                            
                                }
                            
                            }
                        }
                        .padding()
                        .disabled(matchingManager.time < 0 ? false : true)
                        .scaleEffect(matchingManager.lastID == pair.id ? 1.2 : 1.0)
                       
                        .onChange(of: pair.isMatched) { value in
                            if value {
                                for i in matchingManager.matching.pairs.indices {
                                    if matchingManager.matching.pairs[i].text == pair.text {
                                      
                                        withAnimation(.easeOut(duration: 2.0)) {
                                           
                                            matchingManager.matching.pairs[i].isMatched = true
                                            }
                                           
                                    
                                    }
                            }
                        }
                           
                        
                        
                        
                    }
                }
            }
            }
            .onChange(of: matchingManager.matching.pairs) { value in
                withAnimation(.easeOut(duration: 0.5)) {
               done = matchingManager.matching.pairs.filter { card in
                    return card.isMatched
                }.count > 5
                }
                
            }
            
            if done {
            
                MatchingSuccessCardView(matchingManager: matchingManager)
                    .padding()
                    .transition(.opacity)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                       
                        confetti = true
                        }
                    }
                if confetti {
                ForEach(0...20, id: \.self) { _ in
                    ConfettiView()
                }
                }
            
            
        }
        }
    }
}
