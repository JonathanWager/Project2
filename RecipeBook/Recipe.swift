//
//  Recipe.swift
//  RecipeBook
//
//  Created by Jonathan Wåger on 2023-11-08.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    var title: String
    var ingredients: [String]
    var instructions: [String]
    var imageName: String
}
