//
//  HardGameView.swift
//  GuessNBA
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI

struct HardGameView: View {
    
    // this will get the view model.
    @StateObject var hardGameVM = GameViewModel()
    
    var body: some View {
        ZStack {
            // this is to display the background from the background file.
            BackgroundView()
            VStack {
                // this is the text of the amount of questions
                questionCounter
                // getting the view from the hard questions file.
                HardQuestionView()
            }
            .navigationBarHidden(true)
            //getting the view model from the game view model
            .environmentObject(hardGameVM)
        }
        // this will navigate to the next question with correct and incorrect depending on how many questions there are
        .background(
            NavigationLink(destination: ResultsView(scoreVM: ScoreViewModel(answersCorrect: hardGameVM.userGotRight, answersIncorrect: hardGameVM.userGotWrong)),
                           isActive: .constant(hardGameVM.checkIfGameisFinished),
                           // isActive will check if the game has finished.
                           label: { EmptyView() })
        )
    }
}

struct HardGameView_Previews: PreviewProvider {
    static var previews: some View {
        HardGameView()
    }
}

extension HardGameView {
    
    //question counter
    private var questionCounter: some View {
        Text(hardGameVM.questionCounterText)
            .font(.title3)
            .multilineTextAlignment(.leading)
            .padding()
    }
    
    
    
}
