//
//  ScoreViewModel.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import Foundation

// this is used to present the correct answers and the incorrect answers.
struct ScoreViewModel {
    let answersCorrect: Int
    let answersIncorrect: Int
    
    // once the user has finished the game, this will calculate the percent of the user's result.
    var percentage: Int {
        (answersCorrect * 100 / (answersCorrect + answersIncorrect))
    }
}

