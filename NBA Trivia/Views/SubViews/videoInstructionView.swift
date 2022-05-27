//
//  videoInstructionView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 29/04/2022.
//

import SwiftUI

struct videoInstructionView: View {
    
    
    var body: some View {
        ZStack {
            // this is to display the background from the background file.
            BackgroundView()
            VStack(alignment: .center, spacing: 20) {
                //description text of video before playing the game
                videoDescriptionText
                // video image displayed to show the user what the youtube image/ thumbnail look like
                vidImage
                // start button to launch to video guesser game
                vidStartButton
            }
        }
    }
}

struct videoInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        videoInstructionView()
    }
}

extension videoInstructionView {
    
    //video description Text
    private var videoDescriptionText: some View {
        Text("Please remember to have 'Top 10 Dunks of the Decade' ready on another device. This video is found on Youtube.", comment: "description before the video guesser game")
            .font(.title2)
            .foregroundColor(.white)
            .bold()
            .multilineTextAlignment(.center)
    }
    
    // image/thumnail
    private var vidImage: some View {
        Image("thumbnail of YT video")
            .resizable()
            .frame(width: 350, height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(20)
    }
    
    // start button with modifiers.
    private var vidStartButton: some View {
        NavigationLink(destination: VideoView()) {
            // modifiers of the text button.
            Text(LocalizedStringKey("START"), comment: "blue button for the user in the welcome screen and video instructions screen")
                .bold()
                .frame(width: 280, height: 50)
            // this is the background of the circle
                .background(.blue)
            // text colour
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(5)
        }
    }
    
}
