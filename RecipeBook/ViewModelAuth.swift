//
//  ViewModelAuth.swift
//  RecipeBook
//
//  Created by Jonathan Wåger on 2023-10-31.
//

import SwiftUI
import Firebase
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUserUID: String?
    
    init() {
        Auth.auth().addStateDidChangeListener { (_, user) in
            self.isAuthenticated = user != nil
            self.currentUserUID = user?.uid
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { _, error in
            completion(error)
        })
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { _, error in
            completion(error)
        })
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        isAuthenticated = false
    }
    
    func saveRecipe(recipe: Recipe) {
        guard let currentUserUID = currentUserUID else {
                print("Error: currentUserUID is nil")
                return
            }

            let recipeData: [String: Any] = [
                "title": recipe.title,
                "ingredients": recipe.ingredients,
                "instructions": recipe.instructions,
                "imageName": recipe.imageName
            ]

            let userRecipesCollection = Firestore.firestore().collection("users").document(currentUserUID).collection("savedRecipes")

            userRecipesCollection.addDocument(data: recipeData) { error in
                if let error = error {
                    print("Error saving recipe: \(error.localizedDescription)")
                } else {
                    print("Recipe saved successfully!")
                }
            }
        }
}


