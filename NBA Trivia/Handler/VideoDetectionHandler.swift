//
//  VideoDetectionHandler.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 20/03/2022.
// The app was inspired by "Anyone can code" https://www.youtube.com/watch?v=XMnH1vVzqWU&t=404s , also the app to generate the catalog and  signature file is from https://apps.apple.com/app/id1599264580 , so that it's not required to have an Apple developer program.

import Foundation
import ShazamKit


//this will handle the content view to see if it matches
protocol VideoDetectionHandlerDelegate {
    func foundVideo(info: VideoInfo, timestamp: TimeInterval)
}

//SHSessionDelegate requires to have the NSObject to be an object.  This is basically to create a function called and find the match
class VideoDetectionHandler: NSObject, SHSessionDelegate {
    //this is basically handling all the microphone inputs
    let audEngine = AVAudioEngine()
    // manages matching a specific audio recording
    var session: SHSession!
    
    var delegate: VideoDetectionHandlerDelegate?
    
    func settingUp() {
        //putting the custom catalogs in a catalog
        let catalog = SHCustomCatalog()
        
        for vid in videos {
            if let signature = getSignature(name: vid.signatureFileName) {
                try? catalog.addReferenceSignature(signature, representing: [SHMediaItem(properties: [.videoInfo : vid])])
            }
        }
        // assigning the catalog to its session once its set up
        session = SHSession(catalog: catalog)
        session.delegate = self
        
        //grabbing the format of the audio
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: audEngine.inputNode.outputFormat(forBus: 0).sampleRate, channels: 1)
        // grabs all the buffers/ microphone data and get the time of the vid audio
        audEngine.inputNode.installTap(onBus: 0, bufferSize: 2048, format: audioFormat) { [weak session]
            buffer, audioTime in session?.matchStreamingBuffer(buffer, at: audioTime)
        }
        
        try? AVAudioSession.sharedInstance().setCategory(.record)
        
        //Requesting permision and if accessed, start playing audio.
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] success in
            guard success else { return }
            try? self?.audEngine.start()
        }
        
    }
    
    //gets the signature name file
    func getSignature(name: String) -> SHSignature? {
        guard let signatureURL = Bundle.main.url(forResource: name, withExtension: "shazamsignature") else {
            return nil
        }
        //these are basically throwing the initialisers
        do {
            let signatureData = try Data(contentsOf: signatureURL)
            return try SHSignature(dataRepresentation: signatureData)
        } catch {
            // print error if not found
            print(error)
            return nil
        }
    }
    
    // session of whether if the audio matches to the specific video
    func session(_ session: SHSession, didFind match: SHMatch) {
        guard let item = match.mediaItems.first,
              let videoInfo = item.videoInfo else { return }
        //predicting where the time is in the video
        delegate?.foundVideo(info: videoInfo, timestamp: item.predictedCurrentMatchOffset)
    }
}
