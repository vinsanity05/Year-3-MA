//
//  walkthroughView.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 29/04/2022.


import SwiftUI


// This is going to return nothing to avoid closure.
typealias walkthroughBeginAction = () -> Void

struct walkthroughView: View {
    
    // this is the button title and it will be localized for different languages.
    @State private var button = LocalizedStringKey("BEGIN")
    
    //this will present a presentation when the user opens the app.
    @Environment(\.presentationMode) private var presentationMode
    
    //this will call the model
    let itemModel: WalkthroughItem
    
    // this will limit the pages
    let limitOfPages: Int
    // this will handle the button
    let handler: walkthroughBeginAction
    
    // check how many pages.
    @Binding var indexOfPage: Int
    
    //this will set our binding.
    init(item: WalkthroughItem,
         limitOfPages: Int,
         indexOfPage: Binding<Int>,
         //This leaves the scope that it's passed it to.
         handler: @escaping walkthroughBeginAction) {
        // creates the instances
        self.itemModel = item
        self.limitOfPages = limitOfPages
        self._indexOfPage = indexOfPage
        self.handler = handler
    }
    
    var body: some View {
        VStack {
            Spacer()
            //this will display the assets
            itemModel.assetImages?.settingTheAssets
            // calling the big text title
            bigTextTitle
            //little desription on what it will contain.
            descriptionText
            // calling the button
            beginButton
        }
        .padding(.bottom, 150)
    }
    
}

struct walkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        //dummy data just to see if this works
        walkthroughView(item: WalkthroughItem( bigText: "Welcome To NBA Trivia!", description: "Got what it takes to test your NBA Knowledge?"),
                        limitOfPages: 0, indexOfPage: .constant(0)) {}
            .background(            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.8), Color(red: 0.6, green: 0.3, blue: 0.7)]), startPoint: .top, endPoint: .bottom)
            )
    }
}

extension walkthroughView {
    
    //big text / title
    private var bigTextTitle: some View {
        // this will create an empty string if nothings there from the ??.
        Text(itemModel.bigText ?? "", comment: "big title of the text")
            .font(.system(size: 32, weight: .bold))
            .multilineTextAlignment(.center)
            .padding(.bottom,2)
            .foregroundColor(.white)
    }
    
    // little description text
    private var descriptionText: some View {
        Text(itemModel.smallTextDescription ?? "", comment: "little text under the big title")
            .font(.system(size: 12, weight: .semibold))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 50)
            .foregroundColor(.white)
    }
    
    // begin button
    private var beginButton: some View {
        Button(action: {
            // this will leave the screen once the button is tapped.
            presentationMode.wrappedValue.dismiss()
            handler()
        }, label: {
            Text(button, comment: "button for onboarding screen")
        })
        .font(.system(size: 18, weight: .bold))
        .foregroundColor(.white)
        .padding(.horizontal,25)
        .padding(.vertical,10)
        .background(Color.red)
        .clipShape(Capsule())
        .padding(.top, 50)
        //setting the button once it reaches to the end.
        .opacity(indexOfPage == limitOfPages ? 1 : 0)
        // this will allow the user to tap the button.
        .allowsHitTesting(indexOfPage == limitOfPages)
    }
    
}
