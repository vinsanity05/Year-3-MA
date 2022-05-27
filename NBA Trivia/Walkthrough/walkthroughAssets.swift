//
//  walkthroughAssets.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 29/04/2022.
//

import Foundation
import SwiftUI

// type of assets
enum typesOfAssets {
    //sf symbols
    case sfSymbol
    // names in the assets folder
    case xcasset
}

//defining the asset
struct Asset  {
    let nameOfAsset: String
    let type: typesOfAssets
}

extension Asset {
    
    //This will make sure that it can accept one or more views
    @ViewBuilder
    var settingTheAssets: some View {
        
        //this will set the sf symbol with the modifiers.
        switch type {
        case.sfSymbol:
            
            Image(systemName: nameOfAsset)
                .padding(.bottom, 50)
                .font(.system(size: 150, weight: .bold))
            
            //this will set the image from assets folder with modifiers.
        case .xcasset:
            VStack {
                Spacer()
                Image(nameOfAsset)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 150, alignment: .bottom)
                    .padding(.bottom, 50)
            }
        }
    }
}
