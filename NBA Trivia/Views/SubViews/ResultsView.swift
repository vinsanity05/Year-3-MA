//
//  ResultsView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 18/03/2022.
//

import SwiftUI

struct ResultsView: View {
    
    // this will call the score view model
    let scoreVM: ScoreViewModel
    
    
    // This is to represent how much percent that the percent would need to succeed to pass. This represents 70%.
    private let percentageToPass = 0.7
    
    var body: some View {
        ZStack {
            // get the background view file to display the backround.
            BackgroundView()
            VStack {
                VStack {
                    Spacer()
                    // text of description whether they passed or not
                    primaryTextDescription
                    // secondary text description to describe the person or what to do.
                    secondaryTextDescription
                    // Results
                    resultsText
                    // displays the amount of the user's result in percentage.
                    percentageOfResults
                    // these display how much the user has got right or wrong
                    correctAnswers
                    incorrectAnswers
                    Spacer()
                    // This will navigate back to the main menu
                    backToMainMenu
                }
                .onAppear {
                    // this will play the mp3 sound 'win' if the perentage is 0.7 or more
                    if self.percentageOfPlayer {
                        EffectsHandler.effects.playTheSound("win")
                        return
                    }
                    // this will play the mp3 sound 'fail' if the perentage is 0.7 or less
                    EffectsHandler.effects.playTheSound("fail")
                    // this will vibrate the phone for 2 seconds
                    EffectsHandler.effects.vibration(duration: 2)
                }
                
            }
        }
        .navigationBarHidden(true)
    }
}

// preview on how much the user has got.
struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        //win scenario
        ResultsView(scoreVM: ScoreViewModel(answersCorrect: 7, answersIncorrect: 3))
        // uncomment if you want to see the results of the player lose
        //        ResultsView(scoreVM: ScoreViewModel(answersCorrect: 3, answersIncorrect: 7))
        //change to "en" to "fr" for french language
            .environment(\.locale, .init(identifier: "en"))
    }
}

extension ResultsView {
    
    //description text
    private var resultsText: some View {
        Text(LocalizedStringKey("Your Final Score:"), comment: "Final score of the user")
            .font(.system(size: 45))
            .foregroundColor(.white)
            .bold()
            .multilineTextAlignment(.leading)
            .padding()
    }
    
    // percentage of results from the quiz
    private var percentageOfResults: some View {
        Text("\(scoreVM.percentage)%")
            .font(.system(size: 50))
            .bold()
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
    }
    
    // Text to display whether the player has passed the game or not
    private var ResultsOfPlayer: LocalizedStringKey {
        percentageOfPlayer ? "Congratulations! 🎉" : "Unlucky! ☹️"
    }
    
    // another text description of the player
    private var descriptionOfPlayer: LocalizedStringKey {
        percentageOfPlayer ? "You are a true genius!" : "Better luck next time."
    }
    
    // calling the results of player with the modifiers
    private var primaryTextDescription: some View {
        Text(ResultsOfPlayer)
            .font(.system(size: 30))
            .fontWeight(.heavy)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
    }
    
    // calling the description of the player result
    private var secondaryTextDescription: some View {
        Text(descriptionOfPlayer)
            .font(.system(size: 26))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
    }
    
    // This is used to tell the player has passed or not and checks if it will match the percentage.
    private var percentageOfPlayer: Bool {
        let correctAnswer = Double(scoreVM.answersCorrect)
        let incorectAnswer = Double(scoreVM.answersIncorrect)
        return correctAnswer / incorectAnswer >= percentageToPass
        
    }
    
    // correct answers
    private var correctAnswers: some View {
        Text(LocalizedStringKey("Correct ✅: \(scoreVM.answersCorrect)"), comment: "how many correct answers that the user got")
            .font(.system(size: 50))
            .padding()
    }
    
    // incorrect answers
    private var incorrectAnswers: some View {
        Text(LocalizedStringKey("Incorrect ❌: \(scoreVM.answersIncorrect)"), comment: "how many incorrect answers that the user got")
            .font(.system(size: 50))
            .padding()
    }
    
    // link for the user to go back to the main menu
    private var backToMainMenu: some View {
        NavigationLink(destination: MainMenu()) {
            Text("Return to main menu", comment: "button to return to the main menu")
        }
        .multilineTextAlignment(.leading)
        .foregroundColor(.white)
        .font(.system(size: 24))
        .padding()
    }
}
