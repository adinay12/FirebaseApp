//
//  Note.swift
//  firebaseApp
//
//  Created by Adinay on 26/11/25.
//

import Foundation

struct Note {
    var id: String = UUID().uuidString
    var header: String?
    var note: String?
    var image: String?
    
    
    static func example() -> [Note] {
        [
            Note(header: "Hello", note: "Word", image: ""),
            Note(header: "Hello", note: "Word", image: ""),
            
        ]
    }
}
