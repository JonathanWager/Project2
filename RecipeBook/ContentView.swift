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
    @ObservedObject var authViewModel = AuthViewModel() // Add authentication view model
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isAnimating {
                    if authViewModel.isAuthenticated {
                        SearchRecipe(authViewModel: authViewModel) // Navigate to SearchRecipeView when the user is logged in
                    } else {
                        MainView() // Navigate to MainView when the user is not logged in
                    }
                } else {
                    SplashScreenView()
                        .transition(.opacity)
                }
            }
        }.task {
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
                            
                            Text("Sign in or Sign up")
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
                .navigationBarTitle("") // Clear the navigation bar title
                .navigationBarHidden(true)
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

struct SearchRecipe: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var searchText = ""
    
    var body: some View {
        List {
            SearchBar(text: $searchText)
            ForEach(sampleRecipes.filter {
                searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText)
            }, id: \.id) { recipe in
                NavigationLink(destination: RecipeDetail(recipe: recipe, authViewModel: authViewModel)) {
                    RecipeRow(recipe: recipe)
                }
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color.orange, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .listStyle(PlainListStyle())
        .navigationBarTitle("Recipe")
        .background(.cyan)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Button("Sign Out") {
                authViewModel.signOut()
                if let window = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .first?.windows
                    .first {
                    window.rootViewController = UIHostingController(rootView: ContentView())
                    window.makeKeyAndVisible()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoritesView(authViewModel: authViewModel)) {
                        Image(systemName: "heart.fill")
                        
                    }
                }
            }
        }
    }
    
    struct SearchBar: View {
        @Binding var text: String
        
        var body: some View {
            HStack {
                TextField("Search", text: $text)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.leading, 10)
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .padding(4)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    
    struct RecipeRow: View {
        var recipe: Recipe
        
        var body: some View {
            HStack {
                Image(recipe.imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(recipe.title)
            }
        }
    }
    
    struct RecipeDetail: View{
        var recipe: Recipe
        @ObservedObject var authViewModel: AuthViewModel
        @State private var isRecipeSaved: Bool = false
        
        
        var body: some View{
            VStack {
                Image(recipe.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("Ingredienser:")
                    .font(.headline)
                    .foregroundColor(.white)
                
                List(recipe.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                
                Text("Instruktioner:")
                    .font(.headline)
                    .foregroundColor(.white)
                
                List(recipe.instructions, id: \.self) { instruction in
                    Text(instruction)
                }
            }
            .padding(.top, 20)
            .navigationBarTitle(recipe.title)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color.orange,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                Button(action: {
                    if isRecipeSaved {
                        removeFromSavedRecipes()
                    } else {
                        addToSavedRecipes()
                    }
                }) {
                    Text(isRecipeSaved ? "Remove" : "Save")
                }
            }
            .onAppear {
                checkIfRecipeIsSaved()
                print(isRecipeSaved)
            }
            .background(.cyan)
            
        }
        private func checkIfRecipeIsSaved() {
            guard let userId = authViewModel.currentUserUID else {
                return
            }
            
            let db = Firestore.firestore()
            let savedRecipesRef = db.collection("users").document(userId).collection("savedRecipes")
            
            // Check if the recipe exists in the "savedRecipes" subcollection based on title
            savedRecipesRef.whereField("title", isEqualTo: recipe.title).getDocuments { querySnapshot, error in
                if let error = error {
                    // Handle the error
                    print("Error getting saved recipes: \(error.localizedDescription)")
                    return
                }

                // Check if there is at least one document with the given title
                if let documentCount = querySnapshot?.documents.count, documentCount > 0 {
                    isRecipeSaved = true
                } else {
                    isRecipeSaved = false
                }
            }
        }
        
        private func addToSavedRecipes() {
            guard let userId = authViewModel.currentUserUID else {
                return
            }
            
            let db = Firestore.firestore()
            let savedRecipesRef = db.collection("users").document(userId).collection("savedRecipes")
            
            // Add the recipe to the "savedRecipes" subcollection
            savedRecipesRef.document(recipe.id.uuidString).setData([
                "title": recipe.title,
                "ingredients": recipe.ingredients,
                "instructions": recipe.instructions,
                "imageName": recipe.imageName
            ]) { error in
                if let error = error {
                    print("Error adding recipe to savedRecipes: \(error.localizedDescription)")
                } else {
                    isRecipeSaved = true
                }
            }
        }
        
        private func removeFromSavedRecipes() {
            guard let userId = authViewModel.currentUserUID else {
                return
            }
            
            let db = Firestore.firestore()
            let savedRecipesRef = db.collection("users").document(userId).collection("savedRecipes")
            
            // Remove the recipe from the "savedRecipes" subcollection based on title
            savedRecipesRef.whereField("title", isEqualTo: recipe.title).getDocuments { querySnapshot, error in
                if let error = error {
                    // Handle the error
                    print("Error getting saved recipes: \(error.localizedDescription)")
                    return
                }
                
                // Check if there is at least one document with the given title
                guard let document = querySnapshot?.documents.first else {
                    // Handle the case where the document is not found
                    print("Recipe not found in savedRecipes")
                    return
                }

                // Remove the document with the given title
                savedRecipesRef.document(document.documentID).delete { error in
                    if let error = error {
                        // Handle the error
                        print("Error removing recipe from savedRecipes: \(error.localizedDescription)")
                    } else {
                        isRecipeSaved = false
                    }
                }
            }
        }
    }
    
    struct FavoritesView: View {
        @ObservedObject var authViewModel: AuthViewModel
        @ObservedObject var favoritesViewModel: FavoritesViewModel // You'll need a ViewModel for handling favorites
        
        init(authViewModel: AuthViewModel) {
            self.authViewModel = authViewModel
            self.favoritesViewModel = FavoritesViewModel(authViewModel: authViewModel)
        }
        
        var body: some View {
            List {
                ForEach(favoritesViewModel.savedRecipes, id: \.id) { recipe in
                    NavigationLink(destination: RecipeDetail(recipe: recipe, authViewModel: authViewModel)) {
                        RecipeRow(recipe: recipe)
                    }
                }
            }
            .navigationBarTitle("Saved Recipes")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color.orange, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                // Load saved recipes when the view appears
                favoritesViewModel.loadSavedRecipes()
            }
        }
    }
}





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
                Color.orange
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
                                Text(isSignIn ? "Sign In" : "Sign Up")
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
        .navigationBarTitle("Sign In/Sign Up")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationDestination(isPresented: $readyToNavigate){
            SearchRecipe(authViewModel: authViewModel)
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
