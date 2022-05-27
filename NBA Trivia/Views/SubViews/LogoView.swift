//
//  LogoView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI


// this will display the logo image in the main menu
struct LogoView: View {
    
    var assetImage: String
    
    var body: some View {
        Image(assetImage)
            .resizable()
            .frame(width: 150, height: 150)
            .padding()
            .background(.regularMaterial)
        // shadow inside the frame
            .shadow(radius: 5)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// this is used to display the logos for the questions.
struct questionLogoImage: View {
    
    var assetImage: String
    
    var body: some View {
        Image(assetImage)
            .resizable()
            .frame(width: 275, height: 275)
            .padding()
            .background(.regularMaterial)
            .shadow(radius: 5)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// preview of the logos.
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LogoView(assetImage: "001")
            questionLogoImage(assetImage: "003")
        }
    }
}
