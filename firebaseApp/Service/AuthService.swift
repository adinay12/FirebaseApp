//
//  AuthService.swift
//  firebaseApp
//
//  Created by Adinay on 21/11/25.
//

import FirebaseFirestore
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
            
            
            guard let uid = result?.user.uid else { return }
            
            setUserData(user: user, userId: uid) { [weak self] isAdd in
                if isAdd {
                    self?.signOut()
                    comletion(.success(true))
                } else {
                    return
                }
            }
            
            
            // save name
            
            //            result?.user.uid
        }
    }
    
    
    private func setUserData(user: UserData, userId: String, comletion: @escaping (Bool) -> Void) {
//        print(Auth.auth().currentUser?.uid)
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData(["name": user.name ?? "", "email": user.email]) { err in
                guard err == nil else {
                    comletion(false)
                    return
                }
                
                comletion(true)
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
