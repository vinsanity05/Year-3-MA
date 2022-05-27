//
//  EffectsHandler.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 29/04/2022.
// All the sound effects are from: Zapsplat.com and used a YouTube Tutorial https://www.youtube.com/watch?v=SUA2wzjpYjo, haptics was referenced from the Apple documentation: https://developer.apple.com/documentation/corehaptics

import AVFoundation
import CoreHaptics

// This is to handle the sound effects
final class EffectsHandler {
    
    // This to assign to object
    static let effects = EffectsHandler()
    
    // This is the media player using the AVFoundation kit.
    private var mediaPlayer: AVPlayer!
    
    // the haptic engine
    private var hEngine: CHHapticEngine!
    
    // This will indicate whether the haptic engine will need to restart
    private var restartHaptic = false
    
    // this is to make sure whether the device support haptic feedbacks
    private var supportDeviceHap: Bool {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }
    
    // this will initialise and prepare the haptic feedback
    init() {
        startHaptics()
    }
    
    // this function is used to identify the name of the file and check whether the file is supported
    func playTheSound(_ name: String) {
        guard let url = Bundle.main.url(
            forResource: name,
            withExtension: "mp3"
        ) else {
            fatalError("Failed to find audio file \(name).mp3.")
        }
        mediaPlayer = AVPlayer(url: url)
        mediaPlayer.seek(to: .zero)
        mediaPlayer.play()
    }
    
    // this function will shock / vibrate the user when using on a real device if question is wrong, if the shock is not supported, then it won't do anything.
    func vibration(duration: Double) {
        if !supportDeviceHap {
            return
        }
        do {
            // restart the haptic
            if restartHaptic {
                try hEngine.start()
                restartHaptic = false
            }
            //pattern of the haptic
            let patHaptic = try CHHapticPattern(
                events: [vibrationEvent(duration: duration)],
                parameters: []
            )
            // start the haptic
            let hapticPlayer = try hEngine.makePlayer(with: patHaptic)
            try hapticPlayer.start(atTime: 0)
        }
        // no shock
        catch {
            fatalError("Failed to shock the player, no vibration.")
        }
    }
    // this will create and start the haptic engine, if it does not support, then it won't do anything.
    private func startHaptics() {
        if !supportDeviceHap {
            return
        }
        do {
            // trying to get the haptic
            hEngine = try CHHapticEngine()
            hEngine.stoppedHandler = { _ in
                self.restartHaptic = true
            }
            //start the haptic
            try hEngine.start()
        }
        // device is not supported
        catch {
            fatalError("Failed to prepare haptics.")
        }
    }
    
    //this will stop the haptic feedback after the amount of seconds is finished.
    private func vibrationEvent(duration: Double) -> CHHapticEvent {
        return CHHapticEvent(
            // continous haptic
            eventType: .hapticContinuous,
            // how much vibration there is
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            ],
            relativeTime: 0,
            duration: duration
        )
    }
}
