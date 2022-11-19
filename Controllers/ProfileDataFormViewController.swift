//
//  ProfileDataFormViewController.swift
//  Twitter
//
//  Created by Jennifer Chukwuemeka on 08/11/2022.
//

import UIKit
import PhotosUI

class ProfileDataFormViewController: UIViewController {
    let scrollview : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
        
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fill in your data"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let displayNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.backgroundColor = .secondarySystemFill
        textField.leftViewMode = .always
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.attributedPlaceholder = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.backgroundColor = .secondarySystemFill
        textField.leftViewMode = .always
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let avatarPlaceholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private let bioTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .secondarySystemFill
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "Tell the world about your self"
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 16)
        return textView
        
    }()
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button .layer.masksToBounds =  true
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 29/225, green: 161/255, blue: 242/255, alpha: 1)
        button.isEnabled = false
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        view.backgroundColor = .systemBackground
        view.addSubview(scrollview)
        view.addSubview(hintLabel)
        scrollview.addSubview(avatarPlaceholderImageView)
        scrollview.addSubview(displayNameTextField)
        scrollview.addSubview(userNameTextField)
        scrollview.addSubview(bioTextView)
        scrollview.addSubview(submitButton)
        bioTextView.delegate = self
        displayNameTextField.delegate = self
        userNameTextField.delegate = self
        configureConstraint()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        avatarPlaceholderImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapToUpload)))
      

      
    }
    
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func didTapToDismiss() {
        view.endEditing(true)
   }
    
    func configureConstraint() {
        
      let  scrollviewConstraints = [
        scrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        scrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        scrollview.topAnchor.constraint(equalTo: view.topAnchor),
        scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
     let  hintLabelConstraint = [
        hintLabel.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
        hintLabel.topAnchor.constraint(equalTo: scrollview.topAnchor, constant: 30)
     ]
      let  avatarPlaceholderImageViewConstraints = [
        avatarPlaceholderImageView.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
        avatarPlaceholderImageView.heightAnchor.constraint(equalToConstant: 120),
        avatarPlaceholderImageView.widthAnchor.constraint(equalToConstant: 120),
        avatarPlaceholderImageView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 30)
      ]
        
     let displayNameTextFieldConstaints = [
        displayNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        displayNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        displayNameTextField.topAnchor.constraint(equalTo: avatarPlaceholderImageView.bottomAnchor, constant: 40),
        displayNameTextField.heightAnchor.constraint(equalToConstant: 50)
        
     ]
        
        let userNameTextFieldConstaints = [
            userNameTextField.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            userNameTextField.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
           userNameTextField.topAnchor.constraint(equalTo: displayNameTextField.bottomAnchor, constant: 20),
           userNameTextField.heightAnchor.constraint(equalToConstant: 50)
           
        ]
      let  bioTextViewConstraint = [
        bioTextView.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
       
        bioTextView.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
       bioTextView.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
       bioTextView.heightAnchor.constraint(equalToConstant: 150)
       
        
      ]
     let  submitButtonConstaints = [
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        submitButton.heightAnchor.constraint(equalToConstant: 50),
        submitButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20)
        
     ]
        
        NSLayoutConstraint.activate(scrollviewConstraints)
        NSLayoutConstraint.activate(hintLabelConstraint)
        NSLayoutConstraint.activate(avatarPlaceholderImageViewConstraints)
        NSLayoutConstraint.activate(displayNameTextFieldConstaints)
        NSLayoutConstraint.activate(userNameTextFieldConstaints)
        NSLayoutConstraint.activate(bioTextViewConstraint)
        NSLayoutConstraint.activate(submitButtonConstaints)
        
        
        
    }
    

    
}
extension ProfileDataFormViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
       scrollview.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 150), animated: true)
       
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        if textView.text.isEmpty {
            textView.text = "Tell the world about your self"
            textView.textColor = .gray
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollview.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y), animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    
    }
    
}
extension ProfileDataFormViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
    }
    
}
