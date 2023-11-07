//
//  ViewModelFavorites.swift
//  RecipeBook
//
//  Created by Jonathan Wåger on 2023-11-14.
//

import Foundation
import Firebase
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var savedRecipes: [Recipe] = []

    private var userUID: String?

    init(authViewModel: AuthViewModel) {
        authViewModel.$currentUserUID
            .assign(to: \.userUID, on: self)
            .store(in: &cancellables)
    }

    private var cancellables: Set<AnyCancellable> = []
    
    func loadSavedRecipes() {
        guard let userUID = userUID else {
            return
        }

        let db = Firestore.firestore()
        let savedRecipesRef = db.collection("users").document(userUID).collection("savedRecipes")

        savedRecipesRef.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error loading saved recipes: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No saved recipes found.")
                return
            }

            let recipes: [Recipe] = documents.compactMap { document in
                guard
                    let title = document["title"] as? String,
                    let ingredients = document["ingredients"] as? [String],
                    let instructions = document["instructions"] as? [String],
                    let imageName = document["imageName"] as? String
                else {
                    print("Error extracting recipe data from document.")
                    return nil
                }

                return Recipe(title: title, ingredients: ingredients, instructions: instructions, imageName: imageName)
            }

            DispatchQueue.main.async {
                self.savedRecipes = recipes
            }
        }
    }

}
