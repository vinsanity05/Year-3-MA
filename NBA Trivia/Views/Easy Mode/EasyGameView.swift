//
//  EasyGameView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI

struct EasyGameView: View {
    
    // this will get the view model.
    @StateObject var gameVM = GameViewModel()
    
    var body: some View {
        ZStack {
            // this is to display the background from the background file.
            BackgroundView()
            VStack {
                // this is the text of the amount/ counter of questions
                questionCounter
                // getting the view from the easy questions file.
                EasyQuestionView()
            }
            .navigationBarHidden(true)
            //getting the view model from the game view model
            .environmentObject(gameVM)
        }
        // this will navigate to the next question with correct and incorrect depending on how many questions there are
        .background(
            NavigationLink(destination: ResultsView(scoreVM: ScoreViewModel(answersCorrect: gameVM.userGotRight, answersIncorrect: gameVM.userGotWrong)),
                           //isActive will check if the game has finished.
                           isActive: .constant(gameVM.checkIfGameisFinished),
                           label: { EmptyView() })
        )
    }
}

struct EasyGameView_Previews: PreviewProvider {
    static var previews: some View {
        EasyGameView()
    }
}

extension EasyGameView {
    
    //question counter
    private var questionCounter: some View {
        Text(gameVM.questionCounterText)
            .font(.title3)
            .multilineTextAlignment(.leading)
            .padding()
    }
}
