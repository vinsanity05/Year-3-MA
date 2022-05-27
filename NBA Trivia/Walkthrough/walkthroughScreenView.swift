//
//  walkthroughScreenView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 29/04/2022.


import SwiftUI

struct walkthroughScreenView: View {
    
    //calling the files
    let manageWalkthroughs: walkthroughContentManager
    let handler: walkthroughBeginAction
    
    //this will manage the screens
    @State private var screenChosen = 0
    
    // intialising
    internal init(managingWalk: walkthroughContentManager, handler: @escaping walkthroughBeginAction) {
        self.manageWalkthroughs = managingWalk
        self.handler = handler
    }
    
    var body: some View {
        TabView(selection: $screenChosen) {
            // this will get the arrays from the walkthroughcontentmanager file.
            ForEach(manageWalkthroughs.items.indices, id:\.self) {
                index in walkthroughView(item: manageWalkthroughs.items[index],
                                         limitOfPages: manageWalkthroughs.limitOfPages,
                                         indexOfPage: $screenChosen,
                                         handler: handler)
            }
        }
        //this will display the background
        .background(BackgroundView())
        // sets the style
        .tabViewStyle(PageTabViewStyle())
        // what page your on.
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct walkthroughScreenView_Previews: PreviewProvider {
    static var previews: some View {
        walkthroughScreenView(managingWalk: walkthroughImplementation()) {}
    }
}
