//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pant, Karun on 26/03/20.
//  Copyright © 2020 Pant, Karun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private static let optionsCount = 3
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctIndex = Int.random(in: 0..<optionsCount)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var rotaionDegrees: Double = 0
    @State private var shouldAnimate: Bool = false
    @State private var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [ .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.vertical)
            VStack(spacing: 20) {
                VStack(spacing: 5) {
                    HStack {
                        Text("Tap flag of")
                            .font(.largeTitle)
                            .fontWeight(.black)
                        Text("\(countries[correctIndex])")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    }
                    Text("Right answer: +2")
                    Text("Wrong answer: -1")
                }
                .foregroundColor(.white)
                ForEach(0..<ContentView.optionsCount) { (index) in
                    Flag(country: self.countries[index]) {
                        self.showScore(index)
                    }
                    .opacity(self.isCorrectOption(index) ? 1 : self.opacity)
                    .rotation3DEffect(.degrees(self.isCorrectOption(index) ? self.rotaionDegrees : 0), axis: (x: 0, y:1, z:0))
//                    .animation(self.isCorrectOption(index) ? .easeInOut : nil)
//                    .opacity(withAnimation { self.opacity })
                }
                Text("Current Score: \(score)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                .alert(isPresented: $showingScore) { () -> Alert in
                    Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")){
                        self.prepareQuestion()
                    })
                }
            }
        }
    }
    
    func isCorrectOption(_ optionIndex: Int) -> Bool {
        return optionIndex == correctIndex
    }
    
    func showScore(_ tappedIndex: Int) {
        showingScore = true
        let isCorrect = isCorrectOption(tappedIndex)
        scoreTitle = isCorrect ? "Correct" : "Wrong"
        scoreMessage = isCorrect ? "" : "That's the flag of \(countries[tappedIndex])"
        score = isCorrect ? score + 2 : score - 1
        withAnimation(.spring()) {
            rotaionDegrees = isCorrect ? 360 : 0
        }
        opacity = isCorrect ? 1 : 0.25
    }
    func prepareQuestion() {
        countries.shuffle()
        correctIndex = Int.random(in: 0..<4)
        opacity = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
