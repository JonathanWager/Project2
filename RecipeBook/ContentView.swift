//
//  ContentView.swift
//  RecipeBook
//
//  Created by Jonathan Wåger on 2023-10-20.
//

import SwiftUI
import Firebase


struct ContentView: View {
    @State private var isAnimating = false

    var body: some View {
        NavigationStack{
            ZStack {
                if isAnimating {
                    MainView()
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
                        scale = 10.0
                    }
                }
        }
    }
}


struct MainView: View{
    //THE REAL ONE
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var readyToNavigate : Bool = false
    
    var body: some View{
        GeometryReader{ proxy in
            Color(.orange)
            ScrollView{
                ZStack{
                    Color(.orange)
                        .ignoresSafeArea(.all, edges: .all)
                    
                    VStack(spacing: 20){
                        Spacer()
                        
                        // Header
                        Spacer()
                        VStack(spacing: 0){
                            Text("Recipe Book")
                                .font(.system(size: 60))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            
                            Text("""
                                 Unlock the door to culinary delight with our recipe app, where every dish is a step closer to a tastier, happier you.
                                 """)
                            .font(.title3)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 10)
                        }//option + comand + left arrow key
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y : isAnimating ? 0 : -40)
                        .animation(.easeOut(duration: 6), value: isAnimating)
                        // Center
                        
                        ZStack{
                            ZStack{
                                
                                Circle()
                                    .stroke(.white.opacity(0.2), lineWidth: 40)
                                    .frame(width: 260, height: 260, alignment: .center)
                                Circle()
                                    .stroke(.white.opacity(0.2), lineWidth: 80)
                                    .frame(width: 260, height: 260, alignment: .center)
                            }
                            Image("food3")
                                .resizable()
                                .scaledToFit()
                                .opacity(isAnimating ? 1 : 0)
                                .animation(.easeInOut(duration: 8), value: isAnimating)
                        }
                        Spacer()
                        
                        // Footer
                        ZStack{
                            Capsule()
                                .fill(.white.opacity(0.2))
                            
                            Capsule()
                                .fill(.white.opacity(0.2))
                                .padding(8)
                            
                            Text("Log in or Sign in")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(x: 20)
                            
                            HStack{
                                Capsule()
                                    .fill(Color(.red))
                                    .frame(width: buttonOffset + 80)
                                Spacer()
                            }
                            
                            HStack{
                                ZStack{
                                    Circle()
                                        .fill(Color(.red))
                                    Circle()
                                        .fill(.black.opacity(0.15))
                                        .padding(8)
                                    Image(systemName:"chevron.right.2")
                                        .font(.system(size: 24, weight: .bold))
                                }
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80, alignment: .center)
                                .offset(x: buttonOffset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                                                buttonOffset = gesture.translation.width
                                                
                                            }
                                        }
                                        .onEnded{_ in
                                            if buttonOffset > buttonWidth/2{
                                                buttonOffset = buttonWidth - 80
                                                readyToNavigate = true
                                                buttonOffset = 0
                                            }
                                            else{
                                                buttonOffset = 0
                                            }
                                        }
                                )
                                Spacer()
                            }
                            
                        }
                        .frame(width: buttonWidth, height: 80, alignment: .center)
                        .padding()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y : isAnimating ? 0 : 40)
                        .animation(.easeOut(duration: 5), value: isAnimating)
                        Spacer()
                    }
                }
                .navigationDestination(isPresented: $readyToNavigate){
                    LogInView(authViewModel: authViewModel)
                }
                .onAppear(perform:{
                    isAnimating = true
                })
                .frame(minHeight: proxy.size.height)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SearchRecipe: View{
    var body: some View {
        Text("Hello")
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

/*struct MainView: View {
    @ObservedObject var authViewModel = AuthViewModel()
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
                
                NavigationLink(destination: LogInView(authViewModel: authViewModel)) {
                    Text("Log in/Sign in")
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                                .fill(Color.orange) // Background color (orange)
                                .overlay(
                                RoundedRectangle(cornerRadius: 10) // Rounded rectangle with border
                                .stroke(lineWidth: 2) // Border color and width
                                )
                        )
                }
            }
        }
    }
}
 */

/*struct LogInView: View{
    var body: some View{
        ZStack{
            Color.cyan
            
        }
        .navigationTitle("Log In/Sign In")
        .toolbarBackground(
            Color.orange,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
 */
struct LogInView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isSignIn = true
    @State private var errorMessage: String?
    @State private var readyToNavigate : Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader{ proxy in
                Color.cyan
                ScrollView{
                    VStack {
                        ZStack{
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 40)
                                .frame(width: 260, height: 260, alignment: .center)
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 80)
                                .frame(width: 260, height: 260, alignment: .center)
                        }
                        Spacer()
                        VStack{
                            Text("Log In/Sign In")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            
                            TextField("Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            Button(action: {
                                if isSignIn {
                                    signIn()
                                } else {
                                    signUp()
                                }
                            }) {
                                Text(isSignIn ? "Log In" : "Sign Up")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(10)
                            
                            if let errorMessage = errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                            }
                            
                            Toggle(isOn: $isSignIn) {
                                Text(isSignIn ? "Don't have an account? Sign up" : "Already have an account? Log In")
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                        .background(Color.white)
                        ZStack{
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 40)
                                .frame(width: 260, height: 260, alignment: .center)
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 80)
                                .frame(width: 260, height: 260, alignment: .center)
                        }
                        
                    }
                    .ignoresSafeArea(.all, edges: .all)
                    .frame(minHeight: proxy.size.height)
                }
                .edgesIgnoringSafeArea(.all)
            }
            .ignoresSafeArea(.all, edges: .all)
        }
        .navigationBarTitle("Log In/Sign In")
        .toolbarBackground(
            Color.orange,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationDestination(isPresented: $readyToNavigate){
            SearchRecipe()
        }
        .onAppear {
            authViewModel.signOut()
        }
    }
    
    func signUp() {
        authViewModel.signUp(email: email, password: password) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = nil
            }
        }
    }
    
    func signIn() {
        authViewModel.login(email: email, password: password) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = nil
                readyToNavigate = true
            }
        }
    }
}



struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
