//
//  MainMenu.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 19/02/2022.
// the navigation bar button customisation was used since the blue navigation title colour was not seen when the user clicks back to the main menu. This documentation helped create a suitable colour for the button - this helped change it to white: https://developer.apple.com/documentation/uikit/uinavigationcontroller/customizing_your_app_s_navigation_bar

import SwiftUI

struct MainMenu: View {
    
    // this will initialise the navigation title, this will allow it to change colour and the tint, etc.
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.white
        
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                // this is to display the background from the background file.
                BackgroundView()
                ScrollView {
                    VStack {
                        // this will give out a description on what the user has to do.
                        instructionToPlay
                        Spacer()
                        // this will link to the easy game. The image is golden state warriors - current NBA logo so most users will know this logo but the game will consist of current and historical logos.
                        easyText
                        NavigationLink(destination: EasyGameView()) {
                            LogoView(assetImage: "021")
                        }
                        Spacer()
                        // this will link to the hard game. The image is Memphis Grizzlies - This is a historic NBA logo so not a lot of people will know this but the game will consist of current and historical logos.
                        hardText
                        NavigationLink(destination: HardGameView()) {
                            LogoView(assetImage: "032")
                        }
                        Spacer()
                        // this will link to the video guesser game.
                        videoguesserText
                        NavigationLink(destination: videoInstructionView()) {
                            LogoView(assetImage: "Nba Video Guesser")
                        }
                    }
                }
            }
            // title of the main menu quiz.
            .navigationTitle("NBA Trivia!")
        }
        .navigationBarHidden(true)
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}

extension MainMenu {
    //selecting quiz description
    private var instructionToPlay: some View {
        Text(LocalizedStringKey("Please select a quiz you want to play!"),comment: "quiz description of main menu")
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
    }
    
    //Easy text
    private var easyText: some View {
        Text(LocalizedStringKey("Easy"), comment: "Easy mode title")
            .font(.title2)
    }
    
    //Hard text
    private var hardText: some View {
        Text(LocalizedStringKey("Hard"), comment: "Hard mode title")
            .font(.title2)
    }
    
    //videoGuesser text
    private var videoguesserText: some View {
        Text(LocalizedStringKey("Video Guesser"), comment: "Video guesser title")
            .font(.title2)
    }
    
}
