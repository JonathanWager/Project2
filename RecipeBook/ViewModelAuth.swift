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
    @Published var user: User?
    
    init() {
        Auth.auth().addStateDidChangeListener { (_, user) in
            self.user = user
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
    }
}
