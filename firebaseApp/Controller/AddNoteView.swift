//
//  AddNoteView.swift
//  firebaseApp
//
//  Created by Adinay on 27/11/25.
//

import UIKit
import SnapKit

class AddNoteView: UIViewController {
    
    private let viewBuilder = ViewBuilder()
    private let noteService = NoteService()
    var note: Note?
    var image: UIImage?
    
  private lazy var noteHeader = viewBuilder.createTextField(
        frame: .zero,
        placeholder: "Header"
    )
    
   private lazy var noteText: UITextView = {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 12
        $0.font = .systemFont(ofSize: 16)
        return $0
    }(UITextView())
    
    lazy var saveAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        
        let header = noteHeader.text ?? ""
        let noteText = noteText.text ?? ""
        let noteItem = Note(header: header, note: noteText, date: Date(), image: nil)
        
        if note == nil {
            noteService.createNote(note: noteItem) { result in
                switch result {
                case .success(let isAdd):
                    if isAdd {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                case .failure(let failure):
                    print(failure)
                }
            }
        } else {
            noteService.updateNote(noteId: note?.id ?? "", note: noteItem) { isAdd in
                if isAdd {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
    
    lazy var saveBtn = viewBuilder.ctreateButton(
        frame: .zero,
        action: saveAction,
        title: note != nil ? "Update" : "Save",
        isMainBtn: true
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Add note"
        
        noteHeader.text = note?.header
        noteText.text = note?.note
        
        setupLayout()
    }
    
    
    private func setupLayout() {
        view.addSubview(noteHeader)
        view.addSubview(noteText)
        view.addSubview(saveBtn)
        
        noteHeader.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        noteText.snp.makeConstraints { make in
            make.top.equalTo(noteHeader.snp.bottom).offset(20)
            make.left.right.equalTo(noteHeader)
            make.height.equalTo(180)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.left.right.equalTo(noteHeader)
            make.height.equalTo(55)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
        }
    }
}
