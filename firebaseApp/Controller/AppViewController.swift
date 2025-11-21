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
    
    lazy var logOut: UIButton = {
        $0.setTitle("Выйти", for: .normal)
        $0.frame = CGRect(x: 30, y: view.frame.height - 100, width: view.frame.width - 60, height: 50)
        return $0
    }(UIButton(primaryAction: UIAction(handler: { [ weak self ] _ in
        guard let self = self else { return }
        self.authService.signOut()
        print("hhhhhh")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "routeVC"), object: nil, userInfo: ["vc": WindowCase.login] )
    })))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logOut)
    }
}
