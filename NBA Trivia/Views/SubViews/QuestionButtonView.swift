//
//  QuestionButtonView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI


// this is used for the user when displaying the questions.
struct QuestionButtonView: View {
    // this will be the text for the user when they press the button on it.
    let buttonText: String
    
    var body: some View {
        // this will localize the string if ever.
        Text(LocalizedStringKey(buttonText))
            .font(.callout)
            .bold()
            .multilineTextAlignment(.leading)
            .padding()
            .border(.red, width: 4)
    }
}

// preview on what the button would look like.
struct QuestionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionButtonView(buttonText: "NBA Team")
    }
}
