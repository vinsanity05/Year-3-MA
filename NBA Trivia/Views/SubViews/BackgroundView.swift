//
//  BackgroundView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI


struct BackgroundView: View {
    
    var body: some View {
        VStack {
            // this is display the background. The gradient will go from top to bottom.
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.8), Color(red: 0.6, green: 0.1, blue: 0.7)]), startPoint: .top, endPoint: .bottom)
        }
        // this is used to display the entire screen.
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
