//
//  LaunchScreenView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 18/03/2022.
// This launch screen view tutorial was inspired from Swiftul Thinking https://www.youtube.com/watch?v=OLk9hOi7zCM&t=216s

import SwiftUI

struct LaunchScreenView: View {
    
    // this is the text information that will load up on the launch screen and this is to map all the characters of the string, this is turned into an array.
    @State private var loadTheText: [String] = "Loading NBA Trivia...".map {
        String($0)
    }
    
    
    // a boolean to set the loading text whether true or false.
    @State private var showTheLoadText: Bool = false
    // time of the letters going up and down.
    private let timerOfLetter = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // counting how many loops there is
    @State private var countingLoops: Int = 0
    // how many loops it will use when launching the screen
    @State private var howManyLoops: Int = 0
    //boolean to show the launch screen
    @Binding var showLaunch: Bool
    
    
    var body: some View {
        ZStack {
            // using the background view to display the background
            BackgroundView()
            // image of the app logo and modifiers
            Image("App logo")
                .resizable()
                .frame(width:100, height: 100)
            // this is used to animate the loading text
            ZStack {
                if showTheLoadText {
                    loadingTheTextonScreen
                }
            }
            // setting the text to move down so it won't go in the middle
            .offset(y:70)
        }
        // appear on the screen.
        .onAppear {
            showTheLoadText.toggle()
        }
        // this is used to animate and perform the character and set how much loops till it finishes.
        .onReceive(timerOfLetter, perform: { _ in
            withAnimation(.spring()) {
                // counting how many loops and will return to the first index
                let lastIndex = loadTheText.count - 1
                if countingLoops == lastIndex {
                    countingLoops = 0
                    // increment the loops
                    howManyLoops += 1
                    // limit of how many loops there is
                    if howManyLoops >= 2 {
                        showLaunch = false
                    }
                    // if the limit is reached, count the loops
                } else {
                    countingLoops += 1
                }
            }
        })
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        // basically used to create a binding to a value that cannot change. This is helpful just to see on different views
        LaunchScreenView(showLaunch: .constant(true))
        
    }
}

extension LaunchScreenView {
    
    //this is used for every character of loading the text and to move up and down and modifiers to look appealing. This has animation when the screen launches.
    private var loadingTheTextonScreen: some View {
        HStack(spacing: 0) {
            ForEach(loadTheText.indices, id:\.self) { index in
                // tried localizing it - but not sure why it isn't localizing
                Text(LocalizedStringKey(loadTheText[index]),comment: "loading text launch screen")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .offset(y: countingLoops == index ? -5 : 0)
            }
        }
        .transition(AnyTransition.scale.animation(.easeIn))
    }
    
}
