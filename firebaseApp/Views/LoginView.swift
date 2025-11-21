//
//  LoginView.swift
//  firebaseApp
//
//  Created by Adinay on 20/11/25.
//


//final class LoginView: UIView {

//    // MARK: - Callbacks
//    var onLoginTap: ((_ email: String, _ password: String) -> Void)?
//    var onSignupTap: (() -> Void)?
//
//    // MARK: - UI
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Авторизазия"
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        return label
//    }()
//
//    private let emailTF: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Email"
//        tf.borderStyle = .roundedRect
//        return tf
//    }()
//
//    private let passwordTF: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Password"
//        tf.isSecureTextEntry = true
//        tf.borderStyle = .roundedRect
//        return tf
//    }()
//
//    private let loginButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("Войти", for: .normal)
//        btn.backgroundColor = .black
//        btn.setTitleColor(.white, for: .normal)
//        btn.layer.cornerRadius = 8
//        return btn
//    }()
//
//    private let signupButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("Регистрация", for: .normal)
//        return btn
//    }()
//
//    // MARK: - Init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//        setup()
//        applyConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Setup
//
//    private func setup() {
//        addSubview(titleLabel)
//        addSubview(emailTF)
//        addSubview(passwordTF)
//        addSubview(loginButton)
//        addSubview(signupButton)
//
////        loginButton.addAction(UIAction(handler: { [weak self] _ in
////            self?.onLoginTap?(self?.emailTF.text ?? "", self?.passwordTF.text ?? "")
////        }), for: .touchUpInside)
////
////        signupButton.addAction(UIAction(handler: { [weak self] _ in
////            self?.onSignupTap?()
////        }), for: .touchUpInside)
//    }
//
//    // MARK: - Layout
//
//    private func applyConstraints() {
//        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(120)
//            $0.centerX.equalToSuperview()
//        }
//
//        emailTF.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
//            $0.left.right.equalToSuperview().inset(30)
//            $0.height.equalTo(50)
//        }
//
//        passwordTF.snp.makeConstraints {
//            $0.top.equalTo(emailTF.snp.bottom).offset(20)
//            $0.left.right.equalToSuperview().inset(30)
//            $0.height.equalTo(50)
//        }
//
//        loginButton.snp.makeConstraints {
//            $0.top.equalTo(passwordTF.snp.bottom).offset(40)
//            $0.left.right.equalToSuperview().inset(30)
//            $0.height.equalTo(50)
//        }
//
//        signupButton.snp.makeConstraints {
//            $0.top.equalTo(loginButton.snp.bottom).offset(10)
//            $0.left.right.equalToSuperview().inset(30)
//            $0.height.equalTo(44)
//        }
//    }
//}
