//
//  Note.swift
//  firebaseApp
//
//  Created by Adinay on 26/11/25.
//

import Foundation

struct Note: Identifiable {
    var id: String = UUID().uuidString
    let header: String?
    let note: String?
    let date: Date?
    let image: String?
    
    
//    static func example() -> [Note] {
//        [
//            Note(header: "Hello", note: "Word", image: ""),
//            Note(header: "Hello", note: "Word", image: ""),
//            
//        ]
//    }
}
