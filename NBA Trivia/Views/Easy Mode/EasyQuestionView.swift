//
//  EasyQuestionView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI

struct EasyQuestionView: View {
    
    // getting the game view model so that it can be updated the questions.
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        ZStack{
            //background of the game.
            BackgroundView()
            VStack {
                Spacer()
                //question of the game
                question
                Spacer()
                //getting the logoimageview file to get the size and then getting the number from the view model
                questionLogoImage(assetImage: gameVM.logo[0].number)
                Spacer()
                VStack {
                    // display two NBA teams next to each other
                    firstTwoColumns
                    
                    // this is the following HStack. since if it was 0..<4 on the other one it will display 4 button/ names next to each other. This is the same principle on the previous H stack/ first two columns.
                    lastTwocolumns
                    
                    // this will display the correct NBA team name
                    correctAnswerTeam
                    
                    // once the guess was made, it will display a next button for the user and it will navigate the user to next question and it will be replicate the same UI but with shuffle questions and logo.
                    if gameVM.wasTheGuessMade {
                        Button(action: { gameVM.updatingTheScreen()
                            gameVM.repeatShuffleLogos()
                        }) {
                            NextButtonView(nextText: "Next")
                        }
                        .padding()
                    }
                }
                Spacer()
            }
        }
    }
}

struct EasyQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        EasyQuestionView()
            .environmentObject(GameViewModel())
    }
}

extension EasyQuestionView {
    
    //question
    private var question: some View {
        Text(LocalizedStringKey("Which NBA logo is this?"),comment: "Description of the question")
            .font(.largeTitle)
            .foregroundColor(.white)
            .bold()
            .multilineTextAlignment(.leading)
        
    }
    
    //first two columns - display 2 NBA team names.
    private var firstTwoColumns: some View {
        HStack {
            // this wil display the number 2 nba teams between each other
            ForEach(0..<2) { index in
                Button {
                    // gets the guesses of the user and shuffles the NBA team name
                    gameVM.makeTheGuess(name: gameVM.shufflingLogos[index].name)
                    gameVM.usersGuess = gameVM.shufflingLogos[index].name
                } label: {
                    // this presents the button from the question button view file, and will shuffle the name every question and it will interact wether if its right or not.
                    QuestionButtonView(buttonText: gameVM.shufflingLogos[index].name + " " + gameVM.correctAndIncorrectText(optionalName: gameVM.shufflingLogos[index].name))
                }
                //Sets the alignment of multiline text in the button.
                .multilineTextAlignment(.leading)
                //text colour
                .foregroundColor(.black)
                // background of the colour when the guess has been made.
                .background(gameVM.colourOfRightAndWrong(optionalName: gameVM.shufflingLogos[index].name))
                // once the guess was made, it will disable the userr to select different buttons
                .disabled(gameVM.wasTheGuessMade)
            }
        }
    }
    
    // last two columns - same principle as the first column
    private var lastTwocolumns: some View {
        HStack {
            ForEach(2..<4) { index in
                Button {
                    gameVM.makeTheGuess(name: gameVM.shufflingLogos[index].name)
                    gameVM.usersGuess = gameVM.shufflingLogos[index].name
                } label: {
                    QuestionButtonView(buttonText: gameVM.shufflingLogos[index].name + " " + gameVM.correctAndIncorrectText(optionalName: gameVM.shufflingLogos[index].name))
                }
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .background(gameVM.colourOfRightAndWrong(optionalName: gameVM.shufflingLogos[index].name))
                .disabled(gameVM.wasTheGuessMade)
            }
        }
    }
    
    // this will pull out the correct answer
    private var correctAnswerTeam: some View {
        Text(gameVM.correctTeamName(optionalName: gameVM.usersGuess))
            .foregroundColor(.white)
            .bold()
            .multilineTextAlignment(.leading)
            .padding()
    }
    
}
