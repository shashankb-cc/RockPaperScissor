//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Shashank B on 21/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usersChoice:String = ""
    @State private var result:String = ""
    @State private var noOfAttemps:Int = 0
    @State private var usersScore: Int = 0
    @State private var showAlert: Bool = false
    @State private var yourFortune:String = ""

    let optionsArray:[String] = ["Rock","Paper","Scissor"]
    let iconsArray: [String] = ["diamond.fill", "newspaper.fill", "scissors.circle.fill"]

    @State private var randomOption = Int.random(in: 0...2)
    var body: some View {
            VStack {
                Text("Rock Paper Scissor")
                    .font(.largeTitle)
                    .foregroundStyle(.purple)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
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
                Text("User option")
                    .font(.title2)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 25))
                HStack (spacing:30) {
                    
                    Button(action: {
                        usersMove(choice: "Rock")
                    }, label: {
                        Image(systemName: "diamond.fill")
                    })
                    
                    Button(action: {
                        usersMove(choice: "Paper")
                    }, label: {
                        Image(systemName: "newspaper.fill")
                    })
                    
                    Button(action: {
                       usersMove(choice: "Scissor")
                    }, label: {
                        Image(systemName: "scissors.circle.fill")
                        

                    })
                }
                .foregroundStyle(LinearGradient(colors: [.gray,.brown], startPoint: .top, endPoint: .bottom))
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
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(usersScore < 3 ? .red : (usersScore >= 3 && usersScore <= 5 ? .yellow : .purple))

                
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(
                LinearGradient(
                    colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.5)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .alert("You have Reached your max Atempts\n", isPresented: $showAlert) {
                Button("Restart",action: restartGame)
              
            } message: {
               Text( "Your score is \(usersScore)")
        }
    }
        
        
    func showWinOrLoose(_ systemChoice: String, _ usersChoice: String) {
        switch (systemChoice, usersChoice) {
        case ("Rock", "Scissor"), ("Scissor", "Paper"), ("Paper", "Rock"):
            usersScore += 1
            result = "Lose"
        case ("Scissor", "Rock"), ("Paper", "Scissor"), ("Rock", "Paper"):
            result = "Win"
        default:
            result = "Tie"
        }
    }
    func restartGame() {
        noOfAttemps = 0
        usersChoice = ""
        result = ""
        yourFortune = ""
        randomOption = Int.random(in: 0...2)
    }
    func usersMove(choice:String){
        guard noOfAttemps < 8 else {
            
            if usersScore < 3 {
                yourFortune += "Your luck went to Goa 🏔️😂"
            } else if usersScore >= 3 && usersScore <= 5 {
                yourFortune += "You are neither lucky nor unlucky 😝"
            } else {
                yourFortune += "Lucky Dude 😎"
            }
            showAlert = true
            return
        }
        randomOption = Int.random(in: 0...2)
        usersChoice = choice
        noOfAttemps+=1
        showWinOrLoose(optionsArray[randomOption], usersChoice)
    }
   
}

#Preview {
    ContentView()
}
