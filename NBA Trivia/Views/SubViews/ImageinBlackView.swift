//
//  ImageinBlackView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI

struct ImageinBlackView: View {
    
    var assetImageinBlack: String
    
    // this is used to display the logo in black.  This will be used in the hard mode.
    var body: some View {
        Image(assetImageinBlack)
            .resizable()
            .frame(width: 275, height: 275)
        // this will change the brightness, the '-' will decrease it.  Without it, it will increase the brightness
            .brightness(-0.88)
            .padding()
            .background(.regularMaterial)
            .shadow(radius: 5)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


struct ImageinBlackView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ImageinBlackView(assetImageinBlack: "001")
            
        }
    }
}
