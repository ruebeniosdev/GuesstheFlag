//
//  ContentView.swift
//  GuesstheFlag
//
//  Created by RUEBEN on 8/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var endGame = false
    @State private var numberofquestionasked = 0
    @State private var score = 0
    @State private var finalScore = 0
    @State private var showingscore = false
    @State private var scoretitle = ""
    @State private  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria","Poland", "Russia","Spain", "UK"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                                   .init(color: Color(red: 0.76, green: 0.15, blue: 0.26) , location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing:15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                   
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
        }
        .alert(scoretitle, isPresented: $showingscore) {
            Button("Continue",action: askQuestion)
        } message: {
            if scoretitle == "Correct Anwser"{
                Text("Your score is \(scoretitle)")

            }
        }
        .alert("finalScore", isPresented: $endGame) {
            Button("Restart", action: askQuestion)
        }message: {
            Text("\(finalScore)")
                .foregroundStyle(.secondary)
                .font(.subheadline.weight(.heavy))
        }
    }
    
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoretitle = "Correct Anwser"
            score += 1
            
            finalScore += 1
            
            
        } else {
            scoretitle = "Wrong!!!😌 That's the flag of \(countries[number])"
            
        }
        
        
        showingscore = true
    }
    
    func askQuestion() {
        if numberofquestionasked == 8 {
            print("\(score)")
            reset()
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            numberofquestionasked += 1
        }
  
    }
    
    func reset() {
        endGame = true
        numberofquestionasked = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
