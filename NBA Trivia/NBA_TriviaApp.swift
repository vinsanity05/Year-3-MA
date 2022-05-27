//
//  NBA_TriviaApp.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import SwiftUI

@main
struct NBA_TriviaApp: App {
    
    // setting the launch screen with a boolean of true
    @State private var showTheLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                // this is to present the welecome screen after the launch screen
                NavigationView {
                    WelcomeScreen()
                        .navigationBarHidden(true)
                }
                
                ZStack {
                    // this will present the launch screen view when opening the app. Once the launch screen finishes with 2 loops, animation will appear and will launch to the welcome screen.
                    if showTheLaunchView {
                        LaunchScreenView(showLaunch: $showTheLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                // this is to make sure that the 2nd Ztack is ontop of the 1st ZStack with the Navigation View
                .zIndex(2.0)
            }
            
        }
    }
}
