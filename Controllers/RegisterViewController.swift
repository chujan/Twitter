//
//  RegisterViewController.swift
//  Twitter
//
//  Created by Jennifer Chukwuemeka on 07/11/2022.
//

import UIKit
import Combine
class RegisterViewController: UIViewController {
    
    private var viewModel = AuthenticationViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let registerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your account"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
        
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        //textField.keyboardType = .default
       // textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button .layer.masksToBounds =  true
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 29/225, green: 161/255, blue: 242/255, alpha: 1)
        button.isEnabled = false
        return button
        
    }()
    
    @objc private func didChangeEmailField() {
        viewModel.email = emailTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    @objc private func didChangePasswordField() {
        viewModel.password = passwordTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    private func bindViews() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        viewModel.$isAuthenticationFormValid.sink { [weak self] validationState in
            self?.registerButton.isEnabled = validationState
        }
        .store(in: &subscriptions)
        
        
        viewModel.$user.sink { [weak self] user in
            guard user != nil else { return}
            
          guard let vc = self?.navigationController?.viewControllers.first as? onBoardingViewController else {return}
            vc.dismiss(animated: true)
        }
        .store(in: &subscriptions)
        viewModel.$error.sink {[weak self] errorString in
            guard let error = errorString else {return}
            self?.presentAlert(with: error)
        }
        .store(in: &subscriptions)
    }
    
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    //    @objc private func didTapToDismiss() {
    //        view.endEditing(true)
    //    }
    //

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(registerTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        configureConstraints()
        bindViews()
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        view.backgroundColor = .systemBackground
//        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
       
    }
    @objc private func didTapRegister() {
        viewModel.createUser()

    }

    

    private func configureConstraints() {
       let registerTitleLabelConstraints = [
        registerTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        registerTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
       ]
        
      let  emailTextFieldConstraint = [
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        emailTextField.topAnchor.constraint(equalTo: registerTitleLabel.bottomAnchor, constant: 20),
        emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        emailTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let  passwordTextFieldConstraint = [
         passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
         passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
          passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          passwordTextField.heightAnchor.constraint(equalToConstant: 60)
          ]
       let  registerButtonConstaint = [
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
        registerButton.widthAnchor.constraint(equalToConstant: 180),
        registerButton.heightAnchor.constraint(equalToConstant: 50)
       ]
        NSLayoutConstraint.activate(registerTitleLabelConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraint)
        NSLayoutConstraint.activate(passwordTextFieldConstraint)
        NSLayoutConstraint.activate(registerButtonConstaint)
    }
    

  

}
