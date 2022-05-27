//
//  GameViewModel.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI


class GameViewModel: ObservableObject {
    
    // this will get the game Model
    @Published var quiz: Quiz
    
    // string of the user guess
    @Published var usersGuess: String = ""
    
    // this will get the correct guesses from the game model
    var userGotRight: Int {
        quiz.countAnswers.correct
    }
    
    // this will get the incorrect guesses from the game model
    var userGotWrong: Int {
        quiz.countAnswers.incorrect
    }
    // this will get the current question from the game model and assign it to the 1st array
    var currentQ: Logo {
        quiz.currentQ[0]
    }
    
    // this is assigned from the logoData Model
    var logo: [Logo]
    var shufflingLogos: [Logo]
    
    // initialise of the instance
    init() {
        let quiz = Quiz()
        self.quiz  = quiz
        self.logo = quiz.currentQ
        self.shufflingLogos = logo.shuffled()
    }
    
    // this is basically adding another question and count how many questions left you have
    var questionCounterText: String {
        "\(quiz.indexOfCurrentQ + 1) / \(quiz.numberOfQ)"
    }
    
    // if the guess was made, present the right question if not present it as an incorrect question.
    var wasTheGuessMade: Bool {
        if let _ = quiz.guesssesOfQuestion[currentQ] {
            return true
        } else {
            return false
        }
    }
    
    // this is to check if the game is over.
    var checkIfGameisFinished: Bool {
        quiz.isTheGameFinish
    }
    
    // this will let the user make a decision to pick the button and will give out a name of the button.
    func makeTheGuess(name: String) {
        quiz.matchCurrentQGuess(name: name)
    }
    
    // this will update to the next screen
    func updatingTheScreen() {
        quiz.updateTheGame()
    }
    
    // this will shuffle the logo again so it won't repreat itself.
    func repeatShuffleLogos() {
        quiz.logoShuffleAgainAfterGuess()
        self.logo = quiz.currentQ
        self.shufflingLogos = logo.shuffled()
    }
    
    // this is the colour when the user has decided what they want. Green will be the right answer, red will be the wrong answer.
    func colourOfRightAndWrong(optionalName: String) -> Color {
        if let guessingNBATeamName = quiz.guesssesOfQuestion[currentQ] {
            if guessingNBATeamName != optionalName {
                return Color.white
            } else if guessingNBATeamName == currentQ.name {
                return Color.green.opacity(0.5)
            } else {
                return Color.red.opacity(0.5)
            }
        } else {
            return Color.white
        }
    }
    // this will add the emoji and add the sound from the effectshandler file and vibration effect to the nba team names once the user has selected the correct answer/incorrect answer
    func correctAndIncorrectText(optionalName: String) -> String {
        if let guessingNBATeamName = quiz.guesssesOfQuestion[currentQ] {
            // presents the name of the nba teams
            if guessingNBATeamName != optionalName {
                return ""
                // presents the correct answer with the sound and emoji
            } else if guessingNBATeamName == currentQ.name {
                EffectsHandler.effects.playTheSound("correct-answer")
                return "✅"
                // presents the incorrect answer with the sound, effect and emoji
            } else {
                EffectsHandler.effects.playTheSound("wrong-answer")
                EffectsHandler.effects.vibration(duration: 0.5)
                return "❌"
            }
            // returns empty
        } else {
            return ""
        }
    }
    
    // this function is used to get the correct NBA team and displays it if the user has gotten the NBA team wrong.
    func correctTeamName(optionalName: String) -> LocalizedStringKey {
        if let guessingNBATeamName = quiz.guesssesOfQuestion[currentQ] {
            if guessingNBATeamName != optionalName {
                return ""
            } else if guessingNBATeamName == currentQ.name {
                return ""
            } else {
                return LocalizedStringKey("The correct answer was: \(currentQ.name)")
            }
        } else {
            return ""
        }
    }
    
}
