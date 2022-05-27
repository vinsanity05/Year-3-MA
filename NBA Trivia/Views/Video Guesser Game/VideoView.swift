//
//  VideoView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 20/03/2022.
//

import SwiftUI

//create container for the views
class GameData: ObservableObject {
    
    //Something that can be be viewed changed by all the other views, the videoinfo is optional because if there is no video being recognised then there is no video
    @Published var vid: VideoInfo? {
        
        //once the video has been changed
        didSet {
            //Dispatchque warning thing error in the main thread
            DispatchQueue.main.async { [self] in hasVideoBeenFound = vid != nil
            }
        }
    }
    
    //assigns to check whether the found video is found
    @Published var hasVideoBeenFound = false
    
    //shuffle the video clips - randomise, and see if it could exist or not
    @Published var shuffleTheVideoClips: [(Image, TimeInterval)]?
    //this will get the circle to change once the question is correct
    @Published var circleQuestionColourChange = false
    // checks how many clips the user has done
    @Published var clipsFinished = 0 {
        didSet {
            //update the circleQuestion - changes the colour and update it between the seconds
            DispatchQueue.main.async { [self] in circleQuestionColourChange = true
                // this is a timer of the button when the colour is changed.
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    self.circleQuestionColourChange = false
                }
            }
        }
    }
    
    // this will reset the questions
    func resettingtheQ() {
        shuffleTheVideoClips = nil
        circleQuestionColourChange = false
        clipsFinished = 0
    }
}


// this will handle the video and detects if it's the right video.
struct VideoView: View, VideoDetectionHandlerDelegate {
    let detectionHandler = VideoDetectionHandler()
    
    @ObservedObject var gameData = GameData()
    
    // variable whether we are in the game or not, can test this by setting this to true to see how it looks in the game.
    @State var inTheGame = false
    
    var body: some View {
        
        //grabs the screen size, width and size of the view
        GeometryReader { geometry in
            VStack {
                // title of the app and gets the image from the assets folder and modifiers to scale it.
                Image("Nba Video Guesser")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.75)
                    .padding(.top, 30)
                
                // grabbing all the paramenters that will include in the game
                if inTheGame {
                    // game screen
                    gameView(insideTheGame: $inTheGame, geometry: geometry, gameData: gameData)
                }
                // starter screen
                else {
                    starterScreenView(insideGame: $inTheGame, geometry: geometry, gameData: gameData)
                }
            }
            .padding(.vertical, 30)
            .frame(width: geometry.size.width, height: geometry.size.height)
            // background changes when the user starts playing the game
            .background(Image(inTheGame ? "background 2" : "background 1" ).resizable().scaledToFill())
            .onAppear {
                detectionHandler.delegate = self
                //setting if the microphone work
                detectionHandler.settingUp()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    // this will check if the video has been found.
    func foundVideo(info: VideoInfo, timestamp: TimeInterval) {
        DispatchQueue.main.async {
            if inTheGame {
                //check if the clip is there, this will arrange around 3 seconds between the time stamp. Once the game has finished it will reset.
                if let shuffleVideoClips = gameData.shuffleTheVideoClips, abs(timestamp - shuffleVideoClips[gameData.clipsFinished].1) < 3 {
                    if gameData.clipsFinished + 1 < shuffleVideoClips.count {
                        // the sound effect does not work on the actual device - not sure why. but it works on simulator.
                        EffectsHandler.effects.playTheSound("correct-answer")
                        gameData.clipsFinished += 1
                    } else {
                        inTheGame = false
                        gameData.resettingtheQ()
                    }
                }
            } else {
                gameData.vid = info
            }
        }
    }
}

// this is the game once the user has started playing
struct gameView: View {
    @Binding var insideTheGame: Bool
    //get the screen size
    var geometry: GeometryProxy
    @ObservedObject var gameData: GameData
    
    var body: some View {
        //shape of the total questions will be displayed
        Circle()
            .fill(gameData.circleQuestionColourChange ? .green : .blue)
            .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
            .overlay(
                Text("\(gameData.clipsFinished + 1)/\(gameData.vid?.clip_video.count ?? 0)")
                    .bold()
                    .foregroundColor(.white)
                    .font(.largeTitle)
            )
        
        Spacer()
        
        // this will shuffle the clips
        if let clipsVid = gameData.shuffleTheVideoClips {
            clipsVid[gameData.clipsFinished].0
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8 * 0.5625)
        }
        
        // this is the text under the video clip
        Text(LocalizedStringKey("Find and play this part of the video"), comment: "instruction when playing the game - find the video")
            .foregroundColor(.white)
            .font(.title2)
            .bold()
        
        Spacer()
        
        // this will get the buttonChangeToggle function and the user can select the restart button and it will reset to the beginning.
        buttonChangeToggle(
            areWePlaying: $insideTheGame,
            fillModifier: { AnyView($0.stroke(restartBtnColour, lineWidth: 2))},
            text: "Restart",
            textColour: restartBtnColour,
            geometry: geometry,
            gameData: gameData
        )
    }
}

// starter screen.
struct starterScreenView: View {
    //Binding because so we can change so instead of having yourself only recieving it, we can change it.
    @Binding var insideGame: Bool
    //get the screen size
    var geometry: GeometryProxy
    @ObservedObject var gameData: GameData
    
    var body: some View {
        if gameData.hasVideoBeenFound {
            Spacer()
            // if the video is recognised the title will display, if not there will be an unknown video or won't show anything
            Text(gameData.vid?.name_of_title ?? "Unknown video")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            //take in a url and it will load that image for the user.
            AsyncImage(url: URL(string: gameData.vid?.thumbnailURL ?? "")) { img in img
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8 * 0.5625)
            } placeholder: {
                ProgressView()
            }
        }
        
        Spacer()
        
        // The text will  will change once the video is found, if it isn't been found yet, it will display "play that vid..."
        Text(gameData.hasVideoBeenFound ? "And without further ado...." : "Play that video to begin!")
            .foregroundColor(.white)
            .padding(.bottom, 30)
            .font(.title2)
        
        //this will toggle once the user has found/play the video. otherwise it will disable the user to press the get started button until it gets played.
        buttonChangeToggle(
            areWePlaying: $insideGame,
            fillModifier: { AnyView($0.fill(gameData.hasVideoBeenFound ? .red : .gray))},
            text: "Let's Get Started!",
            textColour: .white,
            geometry: geometry,
            gameData: gameData
        )
        .disabled(!gameData.hasVideoBeenFound)
    }
}

// button change toggle function.
struct buttonChangeToggle: View {
    // going up the questions.
    @Binding var areWePlaying: Bool
    // closure
    var fillModifier: (Capsule) -> (AnyView)
    var text: LocalizedStringKey
    var textColour: Color
    var geometry: GeometryProxy
    @ObservedObject var gameData: GameData
    
    var body: some View {
        // this will let the user start the game and the if the user wants to reset the game.
        Button {
            areWePlaying.toggle()
            if areWePlaying {
                beginTheGame()
            } else {
                gameData.resettingtheQ()
            }
        } label: {
            Text(text)
                .foregroundColor(textColour)
                .font(.title2)
        }
        .padding(20)
        .frame(width: geometry.size.width * 0.8)
        //on the sides it will just go all around and then back
        .background(fillModifier(Capsule(style: .continuous)))
    }
    // this will let the user begin the game
    func beginTheGame() {
        guard let vid = gameData.vid else {return}
        gameData.shuffleTheVideoClips = vid.clip_video.shuffled()
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
