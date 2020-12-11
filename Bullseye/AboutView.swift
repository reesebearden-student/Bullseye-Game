//
//  AboutView.swift
//  Bullseye
//
//  Created by reese bearden on 12/9/20.
// test

import SwiftUI

struct AboutView: View {
    
    struct textPadding: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("🎯 Bullseye 🎯").font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                Text("This is bullseye, the game. Drag your slider as close as you can to the specified spot. The closer you are, the more points you score")
                    .modifier(textPadding())
                    .multilineTextAlignment(.center)
                Text("Enjoy")
                    .modifier(textPadding())
            }
            .background(Color(red: 144.0/255.0, green: 100.0/268.0, blue: 10.0/255.0).opacity(0.5))
            .navigationBarTitle("About Bullseye")
        }
        .background(Image("Background"), alignment: .center)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(
            .fixed(width: 896.0, height: 414)
        )
    }
}
