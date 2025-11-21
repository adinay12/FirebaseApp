//
//  UserData.swift
//  firebaseApp
//
//  Created by Adinay on 21/11/25.
//

import Foundation

struct UserData: Identifiable {
    var id: String = UUID().uuidString
    let email: String
    let password: String
    var name: String? = nil
}
