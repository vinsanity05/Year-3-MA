//
//  walkthroughContentManager.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 29/04/2022.
//

import Foundation

protocol walkthroughContentManager {
    // This just allows you to get the value
    var limitOfPages: Int { get }
    var items: [WalkthroughItem] { get }
}

final class walkthroughImplementation: walkthroughContentManager {
    
    //limit the pages from the array.
    var limitOfPages: Int {
        items.count - 1
    }
    // setting the array. Also can add more walkthroughs in future if ever.
    let items: [WalkthroughItem] = [
        WalkthroughItem(bigText: "Welcome To NBA Trivia!", description: "Got what it takes to test your NBA Knowledge?",  asset: Asset(nameOfAsset: "checkmark.bubble.fill", type: .sfSymbol)),
        WalkthroughItem(bigText: "Logos", description: "From easy to hard! These include current and historic NBA logos!",  asset: Asset(nameOfAsset: "031", type: .xcasset)),
        WalkthroughItem(bigText: "Video guesser game", description: "And play a video scavenger hunt!  Please get ready this video and search for ‘Top 10 Dunks of the Decade’ on Youtube before you begin!",  asset: Asset(nameOfAsset: "thumbnail of YT video", type: .xcasset))
        // This is commented for scalability to add more walkthrough for future
        //        WalkthroughItem(bigText: "NBA team rankings", description: "Find your favourite NBA team in the NBA team standings!",  asset: Asset(nameOfAsset: "sportscourt.fill", type: .sfSymbol))
    ]
    
}
