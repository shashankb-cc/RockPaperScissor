//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Shashank B on 21/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usersChoice: String = ""
    @State private var result: String = ""
    @State private var noOfAttempts: Int = 0
    @State private var usersScore: Int = 0
    @State private var showAlert: Bool = false
    @State private var yourFortune: String = ""
    
    let optionsArray = ["Rock", "Paper", "Scissor"]
    let iconsArray = ["diamond.fill", "newspaper.fill", "scissors.circle.fill"]
    
    @State private var randomOption = Int.random(in: 0...2)
    
    var body: some View {
        VStack {
            Text("Rock Paper Scissors")
                .font(.largeTitle)
                .foregroundStyle(.purple)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            Text("Test your luck vs System")
                .font(.title3)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            Spacer()
            
            VStack {
                Text("System Choice")
                    .font(.title2)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 25))
                HStack {
                    Text(optionsArray[randomOption])
                    Image(systemName: iconsArray[randomOption])
                }
                .foregroundStyle(.white)
                .padding()
                .background(.purple)
                .clipShape(.capsule)
                .font(.title)
            }
            .font(.largeTitle)
            
            Spacer()
            
            Text("Your Choice")
                .font(.title2)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 25))
            
            HStack(spacing: 30) {
                ForEach(0..<3) { index in
                    Button(action: {
                        usersMove(choice: optionsArray[index])
                    }, label: {
                        Image(systemName: iconsArray[index])
                    })
                }
            }
            .foregroundStyle(LinearGradient(colors: [.gray, .brown], startPoint: .top, endPoint: .bottom))
            .font(.title)
            .padding()
            .background(.yellow)
            .clipShape(.capsule)
            
            HStack {
                Text(usersChoice)
                if let index = optionsArray.firstIndex(of: usersChoice) {
                    Image(systemName: iconsArray[index])
                } else {
                    Image(systemName: "questionmark.circle.fill")
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(.purple)
            .clipShape(.capsule)
            .font(.title)
            
            Spacer()
            
            Text(yourFortune)
                .font(.title2)
                .fontDesign(.serif)
                .fontWeight(.bold)
                .foregroundStyle(usersScore < 3 ? .red : (usersScore >= 3 && usersScore <= 5 ? .yellow : .purple))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .alert("You have reached your max attempts", isPresented: $showAlert) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your score is \(usersScore)")
        }
    }
    
    func showWinOrLose(_ systemChoice: String, _ usersChoice: String) {
        switch (systemChoice, usersChoice) {
        case ("Rock", "Scissor"), ("Scissor", "Paper"), ("Paper", "Rock"):
            result = "Lose"
        case ("Scissor", "Rock"), ("Paper", "Scissor"), ("Rock", "Paper"):
            usersScore += 1
            result = "Win"
        default:
            result = "Tie"
        }
    }
    
    func restartGame() {
        noOfAttempts = 0
        usersChoice = ""
        result = ""
        yourFortune = ""
        usersScore = 0
        randomOption = Int.random(in: 0...2)
    }
    
    func usersMove(choice: String) {
        guard noOfAttempts < 8 else {
            determineFortune()
            showAlert = true
            return
        }
        randomOption = Int.random(in: 0...2)
        usersChoice = choice
        noOfAttempts += 1
        showWinOrLose(optionsArray[randomOption], usersChoice)
    }
    
    func determineFortune() {
        if usersScore < 3 {
            yourFortune = "Your luck went to Goa 🏔️😂"
        } else if usersScore >= 3 && usersScore <= 5 {
            yourFortune = "You are neither lucky nor unlucky 😝"
        } else {
            yourFortune = "Lucky Dude 😎"
        }
    }
}

#Preview {
    ContentView()
}
