//
//  VideoGuesserModel.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 20/03/2022.
//

import Foundation
import SwiftUI
import ShazamKit

// this is the colour of the restart text button.
let restartBtnColour = Color(red: 255/255, green: 255/255, blue: 255/255)

//add property to the signatures. The property is going to be the video info so we can actually put it in there and we can use it. This will make it connect things together
extension SHMediaItemProperty {
    static let videoInfo = SHMediaItemProperty("videoInfo")
}

// once this is match from the audio input, shazam kit is going to give us an SH media item.
extension SHMediaItem {
    // it will vary the videoinfo because it may not exist
    var videoInfo: VideoInfo? {
        self[.videoInfo] as? VideoInfo
    }
}


// contain the information of the video
struct VideoInfo {
    // name of the title of the video
    var name_of_title: String
    // name of the file name of the video
    var signatureFileName: String
    //thumbnail of the video
    var thumbnailURL: String
    // image of the video and the time of the video
    var clip_video: [(Image, TimeInterval)]
}

// this is the video of the "Top 10 Dunks of the decade" on youtube, and getting the signature file and the thumbnail of the vid that was taken from the internet, but we can also add more videos here in the future.
let videos = [
    VideoInfo(
        name_of_title: "Top 10 Dunks of the Decade",
        signatureFileName: "Top 10 Dunks of the decade NBA", thumbnailURL: "https://i.ytimg.com/vi/ue1NT3QhuVU/hqdefault.jpg",
        clip_video: [(Image("Video-guesser1"), 37), (Image("Video-guesser2"), 58),  (Image("Video-guesser3"), 147), (Image("Video-guesser4"), 150), (Image("Video-guesser5"), 85)])
    
]
