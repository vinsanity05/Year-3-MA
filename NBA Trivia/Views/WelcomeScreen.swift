//
//  WelcomeScreen.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//
// Animation of the start button was inspired from hacking with swift. https://www.hackingwithswift.com/books/ios-swiftui/customizing-animations-in-swiftui

import SwiftUI

// this is the welcome screen
struct WelcomeScreen: View {
    
    // this is the animation amount of the start button
    @State private var animationButton = 1.0
    
    //This will manage if the user has seen the walkthrough screen
    @AppStorage("hasSeenWalkthrough") private var hasSeenWalkthrough = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                // this is to display the background from the background file.
                BackgroundView()
                VStack {
                    Spacer()
                    //nba logo
                    NBALogo
                    Spacer()
                    //Image in black bulls logo
                    BlackNBALogo
                    Spacer()
                    // this will navigate the user to the next view once the user has tapped the start button.
                    StartButton
                }
            }
            //This will display the screen
            .fullScreenCover(isPresented: .constant(!hasSeenWalkthrough), content: {
                let walkthroughContentManager = walkthroughImplementation()
                walkthroughScreenView(managingWalk: walkthroughContentManager) {
                    // This lets the user know that they have seen the walkthrough screen so it won't be displayed again.
                    hasSeenWalkthrough = true
                }
            })
        }
        .navigationBarHidden(true)
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
        //change to "en" to "fr" for french language
            .environment(\.locale, .init(identifier: "fr"))
    }
}

extension WelcomeScreen {
    
    //NBA logo
    private var NBALogo: some View {
        Image("nba-big-logo")
            .resizable()
            .frame(width: 250, height: 150, alignment: .center)
    }
    
    //Bulls logo that's black
    private var BlackNBALogo: some View {
        VStack {
            // this is to display the image from the assets folder "003" - chicago bulls. This is displayed in black.
            Rectangle()
                .foregroundColor(.black)
                .frame(width: 250, height: 250)
                .mask(
                    Image("003")
                        .resizable()
                        .frame(width: 250, height: 250)
                )
        }
        .padding()
    }
    
    // button that links to the menu
    private var StartButton: some View {
        NavigationLink(destination: MainMenu()) {
            // modifiers of the text button.
            Text(LocalizedStringKey("START"), comment: "blue button for the user in the welcome screen")
                .bold()
                .padding(50)
            // this is the background of the circle
                .background(.blue)
            // text colour
                .foregroundColor(.white)
                .clipShape(Circle())
            //adding a circle within the text with animation.
                .overlay(
                    Circle()
                        .stroke(.white)
                        .scaleEffect(animationButton)
                        .opacity(2 - animationButton)
                    // duration of the button and will repeat forever till the user clicks the button.
                        .animation(
                            .easeInOut(duration: 2)
                            .repeatForever(autoreverses: false),
                            value: animationButton
                        )
                )
            // this will set the animation button
                .onAppear {
                    animationButton = 2
                }
        }
    }
}

