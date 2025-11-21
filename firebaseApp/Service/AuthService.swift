//
//  AuthService.swift
//  firebaseApp
//
//  Created by Adinay on 21/11/25.
//

import Firebase
import FirebaseAuth
import Foundation

enum SignInError: Error {
    case invalidUser
    case notVerified
}


class AuthService {
    
    func createNewUser(user: UserData, comletion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, err in
            guard let self = self else { return }
            
            guard err == nil else {
                print(err!)
                comletion(.failure(err!))
                return
            }
            result?.user.sendEmailVerification()
            signOut()
            comletion(.success(true))
            
            //            result?.user.uid
        }
    }
    
    
    func singIn(user: UserData, comletion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { [ weak self ]  result, err in
            guard let self = self else { return }
            
            guard err == nil else {
                print(err!)
                comletion(.failure(err!))
                return
            }
            
            guard let user = result?.user else {
                comletion(.failure(SignInError.invalidUser))
                return
            }
            
            if !user.isEmailVerified {
                comletion(.failure(SignInError.notVerified))
                signOut()
                return
            }
            
            comletion(.success(true))
        }
    }
    
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    
    func isLogin() -> Bool {
        if let _ = Auth.auth().currentUser {
            return true
        }
        return false
    }
}
