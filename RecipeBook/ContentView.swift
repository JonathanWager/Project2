//
//  ContentView.swift
//  RecipeBook
//
//  Created by Jonathan Wåger on 2023-10-20.
//

import SwiftUI



struct ContentView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            if isAnimating {
                MainView()
                    //.transition(.scale)
            } else {
                SplashScreenView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 4.0)) {
                isAnimating = true
            }
        }
    }
}

struct SplashScreenView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Color.white
            Circle()
                .fill(Color.orange)
                .scaleEffect(scale)
                .frame(width: 100, height: 100)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2.0)) {
                        scale = 10.0 // Increase the scale value to make the circle grow to the entire screen
                    }
                }
        }
    }
}

/*struct MainView: View {
    var body: some View {
        
        VStack{
            Text("Receptbok")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
        .padding(.bottom,500)
        
        VStack{
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.cyan)
        .padding(.top,259)
    }
}
 */

struct MainView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.orange
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 4)

                /*Color.cyan
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .position(x: geometry.size.width / 2, y: 3 * geometry.size.height / 4)
                 */

                
                Image("food2")
                    .resizable()
                    .frame(height: 633)//380
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.5)
                
                Text("Receptbok")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 8)
            }
        }
    }
}





struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
