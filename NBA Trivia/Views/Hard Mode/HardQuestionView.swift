//
//  HardQuestionView.swift
//  GuessNBA
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI

struct HardQuestionView: View {
    
    // getting the game view model so that it can be updated the questions.
    @EnvironmentObject var hardGameVM: GameViewModel
    
    var body: some View {
        ZStack{
            // this is to display the background from the background file.
            BackgroundView()
            VStack {
                Spacer()
                //question of the game
                question
                Spacer()
                //getting the ImageinBlackView file and then getting the number from the view model
                ImageinBlackView(assetImageinBlack: hardGameVM.logo[0].number)
                Spacer()
                VStack {
                    // this wil display the number 2 nba teams between each other
                    firstTwoColumns
                    // this is the following HStack. since if it was 0..<4 on the other one it will display 4 button/ names next to each other. This is the same principle on the previous H stack / first two columns.
                    lastTwocolumns
                    
                    // this will display the correct NBA team name
                    correctAnswerTeam
                    
                    // once the guess was made, it will display a next button for the user and it will navigate the user to next question and it will be replicate the same UI but with shuffle questions and logo.
                    if hardGameVM.wasTheGuessMade {
                        Button(action: { hardGameVM.updatingTheScreen()
                            hardGameVM.repeatShuffleLogos()
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

struct HardQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        HardQuestionView()
            .environmentObject(GameViewModel())
    }
}

extension HardQuestionView {
    
    //question
    private var question: some View {
        Text(LocalizedStringKey("Which NBA logo is this?"),comment: "Description of the question")
            .font(.largeTitle)
            .foregroundColor(.white)
            .bold()
            .multilineTextAlignment(.leading)
    }
    
    // this is the same principle as the easy question view
    private var firstTwoColumns: some View {
        HStack {
            ForEach(0..<2) { index in
                Button {
                    // gets the guesses of the user and shuffles the NBA team name
                    hardGameVM.makeTheGuess(name: hardGameVM.shufflingLogos[index].name)
                    hardGameVM.usersGuess = hardGameVM.shufflingLogos[index].name
                } label: {
                    // this presents the button from the question button view file, and will shuffle the name every question and it will interact wether if its right or not.
                    QuestionButtonView(buttonText: hardGameVM.shufflingLogos[index].name + " " + hardGameVM.correctAndIncorrectText(optionalName: hardGameVM.shufflingLogos[index].name))
                }
                //Sets the alignment of multiline text in the button.
                .multilineTextAlignment(.leading)
                //text colour
                .foregroundColor(.black)
                // background of the colour when the guess has been made.
                .background(hardGameVM.colourOfRightAndWrong(optionalName: hardGameVM.shufflingLogos[index].name))
                // once the guess was made, it will disable the userr to select different buttons
                .disabled(hardGameVM.wasTheGuessMade)
            }
        }
    }
    
    // this is for the last two columns, same principle as the first two coloumns but it will be underneath it.
    private var lastTwocolumns: some View {
        HStack {
            ForEach(2..<4) { index in
                Button {
                    hardGameVM.makeTheGuess(name: hardGameVM.shufflingLogos[index].name)
                    hardGameVM.usersGuess = hardGameVM.shufflingLogos[index].name
                } label: {
                    QuestionButtonView(buttonText: hardGameVM.shufflingLogos[index].name + " " + hardGameVM.correctAndIncorrectText(optionalName: hardGameVM.shufflingLogos[index].name))
                }
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .background(hardGameVM.colourOfRightAndWrong(optionalName: hardGameVM.shufflingLogos[index].name))
                .disabled(hardGameVM.wasTheGuessMade)
            }
        }
    }
    
    // this will pull out the correct answer
    private var correctAnswerTeam: some View {
        Text(hardGameVM.correctTeamName(optionalName: hardGameVM.usersGuess))
            .foregroundColor(.white)
            .bold()
            .multilineTextAlignment(.leading)
            .padding()
    }
    
}
