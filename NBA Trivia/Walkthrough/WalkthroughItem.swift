//
//  WalkthroughItem.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 29/04/2022.
// The walkthrough tutorial was inspired by Tundsdev https://www.youtube.com/watch?v=HXYqU5ClIk4

import Foundation
import SwiftUI

struct WalkthroughItem: Identifiable {
    
    // most of it is has a ? to check if it has those unless its empty.
    let id = UUID() // create a unique id
    let bigText: LocalizedStringKey? //  this will be the big text when opening the screen
    let smallTextDescription: LocalizedStringKey? // the small description after the big text
    let assetImages: Asset? // this can use either sf symbols or the asset images
    
    
    //  These are property of an instance that holds the instance itself and this can be used just for our preview section.
    init(bigText: LocalizedStringKey? = nil,
         description: LocalizedStringKey? = nil,
         asset: Asset? = nil) {
        self.bigText = bigText
        self.smallTextDescription = description
        self.assetImages = asset
    }
    
}
