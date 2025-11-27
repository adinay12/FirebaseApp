//
//  NoteService.swift
//  firebaseApp
//
//  Created by Adinay on 27/11/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class NoteService {
    // CRUD
    
    func createNote(note: Note, comletion: @escaping (Result<Bool, Error >) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid  else { return  }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(note.id)
            .setData(["header": note.header ?? "", "note": note.note ?? "", "date": Date()]) { err in
                guard err == nil else {
                    comletion(.failure(err!))
                    return }
            }
        comletion(.success(true))
    }
    
    
    func readNotes(comletion: @escaping(Result<[Note], Error>) -> Void )  {
        guard let uid = Auth.auth().currentUser?.uid  else { return  }
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
//            getDocuments
            .addSnapshotListener { snapshot, err in
                guard err == nil else {
                    print(err!)
                    comletion(.failure(err!))
                    return
                }
                
                guard let docs = snapshot?.documents else { return }
                var notes = [Note]()
                
                
                docs.forEach { doc in
                    let header = doc["header"] as? String
                    let noteText = doc ["note"] as? String
                    let dateStamp = doc ["date"] as? Timestamp
                    let date = dateStamp?.dateValue()
                    
                    let note = Note(id: doc.documentID, header: header ?? "" , note: noteText ?? "", date: date ?? Date(), image: nil)
                    notes.append(note)
                    
                }
                
                comletion(.success(notes))
            }
    }
    
    
    
    func updateNote(noteId: String, note: Note, comletion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid  else { return }
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(noteId)
            .updateData(["header": note.header, "note": note.note, "date": Date()]) { err in
                guard err == nil else {
                    print(err!)
                    return
                }
                comletion(true)
            }
    }
    
    
    
    func deleteNote(noteId: String) {
        guard let uid = Auth.auth().currentUser?.uid  else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(noteId)
            .delete()
            }
    }
