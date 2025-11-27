//
//  AppViewController.swift
//  firebaseApp
//
//  Created by Adinay on 20/11/25.
//

import UIKit

class AppViewController: UIViewController {
    private let viewBuilder = ViewBuilder()
    private let authService = AuthService()
//    private let noteService = NoteService()
    var notes: [Note] = Note.example()

    lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .white
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return $0
    }(UITableView(frame: view.frame, style: .grouped))
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addNote))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(logOut))
    }
    
    @objc
    func addNote() {
        let addVC = AddNoteView()
        self.navigationController?.pushViewController(addVC, animated: true
        )
    }
    
    @objc
    func logOut() {
        authService.signOut()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "routeVC"), object: nil, userInfo: ["vc" : WindowCase.login])
    }
}


//
extension AppViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = notes[indexPath.row].header
        config.secondaryText = notes[indexPath.row].note
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addNote = AddNoteView()
        addNote.note = notes[indexPath.row]
        
        self.navigationController?.pushViewController(addNote, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
//            noteService.deleteNote(noteId: note.id)
        }
    }
    
}



//private let viewBuilder = ViewBuilder()
//private let authService = AuthService()
//
//lazy var logOut: UIButton = {
//    $0.setTitle("Выйти", for: .normal)
//    $0.frame = CGRect(x: 30, y: view.frame.height - 100, width: view.frame.width - 60, height: 50)
//    return $0
//}(UIButton(primaryAction: UIAction(handler: { [ weak self ] _ in
//    guard let self = self else { return }
//    self.authService.signOut()
//    print("hhhhhh")
//    NotificationCenter.default.post(name: Notification.Name(rawValue: "routeVC"), object: nil, userInfo: ["vc": WindowCase.login] )
//})))
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = .white
//    view.addSubview(logOut)
//}
