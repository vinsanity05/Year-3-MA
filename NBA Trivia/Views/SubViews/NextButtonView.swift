//
//  NextButtonView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI


// this is to display the next button when the user has selected the question.
struct NextButtonView: View {
    
    let nextText: LocalizedStringKey
    
    var body: some View {
        HStack {
            //without this - this will space to the left
            Spacer()
            Text(nextText)
                .font(.system(size:20, weight: .bold, design:.rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding()
            // this is to align in center with another spacer otherwise it will align it to the right
            Spacer()
        }
        .background(.blue)
    }
}

struct NextButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NextButtonView(nextText: "Next")
    }
}
