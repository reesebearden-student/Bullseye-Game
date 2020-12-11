//
//  ContentView.swift
//  Bullseye
//
//  Created by reese bearden on 12/8/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var score: Int = 0
    @State var target = Int.random(in: 1...100)
    @State var round = 0
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .shadow(color: .black, radius: 10, x: 2.2, y: 3.0)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .shadow(color: .black, radius: 10, x: 2.2, y: 3.0)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ButtonSmallStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .shadow(color: .black, radius: 10, x: 2.2, y: 3.0)
                .font(Font.custom("Arial Rounded MT Bold", size: 14))
        }
    }

    var body: some View {
        
        VStack {
            Spacer()
            // target row
            HStack {
                Text("Put the bullseye as close as you to: ")
                    .modifier(LabelStyle())
                Text("\(target)")
                    .modifier(ValueStyle())
            }
            .padding()
            Spacer()
            
            // slider row
            HStack {
                Text("1")
                    .foregroundColor(Color.white)
                    .shadow(color: .black, radius: 10, x: 2.2, y: 3.0)
                Slider(value: self.$sliderValue, in: 1...100)
                    .accentColor(.green)
                    .shadow(color: .black, radius: 10, x: 2.2, y: 3.0)
                Text("100")
                    .foregroundColor(Color.white)
                    .shadow(color: .black, radius: 10, x: 2.2, y: 3.0)
            }
            
            
            // button row
            Button(action: {
                print("button pressed!")
                self.alertIsVisible = true
                updateScore()
            }) {
                Text("hit me")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                 
            }
            .alert(isPresented: $alertIsVisible) {
                () -> Alert in
                return Alert(title: Text("Hello there"), message: Text("The slider's value is \(Int((self.sliderValue).rounded())) \n " + "you were off by: \(calculuateDifference()) \n" + "You scored \(displayScore()) this round. \n"), dismissButton: .default(Text("\(closenessIndex())")) {
                    updateTarget()
                    round += 1
                })
            }
            .background(Image("Button"))
            .modifier(LabelStyle())
            .padding()
            Spacer()
            
            // score row
            HStack {
                Button(action: {
                    score = 0
                    round = 0
                }) {
                    HStack {
                        Text("Start over")
                            .modifier(ButtonSmallStyle())
                        Image("StartOverIcon")
                    }
                }
                .background(Image("Button"))
                .modifier(LabelStyle())
                .padding()
                Spacer()
                
                HStack {
                    Text("Score: ")
                        .modifier(LabelStyle())
                    Text("\(score)")
                        .modifier(ValueStyle())
                }
                .padding()
                Spacer()
                
                HStack {
                    Text("Round: ")
                        .modifier(LabelStyle())
                    Text("\(round)")
                        .modifier(ValueStyle())
                }
                .padding()
                Spacer()
                
                
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Text("Info")
                            .modifier(ButtonSmallStyle())
                        Image("InfoIcon")
                    }
                }
                .background(Image("Button"))
                .modifier(LabelStyle())
                .padding()
                
            }
            Spacer()
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    func calculuateDifference() -> Int {
        return abs(Int((self.sliderValue).rounded()) - target)
    }
    
    func updateScore() -> Void {
        if (calculuateDifference() == 0) {
            score += 100 + (100 - calculuateDifference())
        }
        else {
            score += (100 - calculuateDifference())
        }
    }
    
    func displayScore() -> Int {
        if (calculuateDifference() == 0)
        {
            return ((100 - calculuateDifference()) + 100)
        }
        else
        {
            return 100 - calculuateDifference()
        }
    }
    
    func updateTarget() -> Void {
        target = Int.random(in: 1...100)
    }
    
    func closenessIndex() -> String {
        if (calculuateDifference() >= 10) {
            return "You're not close!"
        }
        else if (calculuateDifference() < 10 && calculuateDifference() >= 1) {
            return "Pretty close!"
        }
        else {
            return "You got it!"
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewLayout(
                .fixed(width: 896.0, height: 414)
            )
        }
    }
}
