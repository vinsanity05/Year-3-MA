//
//  GameModel.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import Foundation

struct Quiz {
    
    // current question.
    private(set) var indexOfCurrentQ = 0
    
    // guesses of the string name of the logo.
    var guesssesOfQuestion = [Logo: String]()
    // is the game finished.
    private(set) var isTheGameFinish = false
    // shuffles the logo.
    private var logo = Logo.allLogo.shuffled()
    
    // this will count how many the user has gotten correct and incorrect.
    var countAnswers: (correct: Int, incorrect: Int) {
        var counter: (correct: Int, incorrect: Int) = (0,0)
        // for loop to count how many logos that the user got correct and incorrect and increments it by 1 till the end of the questions
        for (logo, guessingNBATeamName) in guesssesOfQuestion {
            if logo.name == guessingNBATeamName {
                counter.correct += 1
            } else {
                counter.incorrect += 1
            }
        }
        return counter
    }
    
    // number of questions.
    var numberOfQ = 10
    
    // current question of logos presented. This will present 4 team names in the game.
    var currentQ: [Logo] { [
        logo[0],
        logo[1],
        logo[2],
        logo[3] ]
    }
    
    // this will reshuffle the logo again for the next question.
    mutating func logoShuffleAgainAfterGuess() {
        // this will remove the specified number of elements from the beginning of the collection.
        logo.removeFirst(1)
        logo = logo.shuffled()
        
    }
    
    // this will check the name and current logo matches.
    mutating func matchCurrentQGuess(name: String) {
        guesssesOfQuestion[(currentQ[0])] = name
    }
    
    // this will update the the game and adds on once the current question is finished and reaches the limit of questions.
    mutating func updateTheGame() {
        if indexOfCurrentQ < numberOfQ - 1 {
            indexOfCurrentQ += 1
        } else {
            isTheGameFinish = true
        }
    }
}
