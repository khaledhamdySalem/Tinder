//
//  RegistrationController.swift
//  Tinder
//
//  Created by KH on 26/08/2022.
//

import UIKit

class RegistrationVC: UIViewController {
    
    let body = RegistrationBody()
    var registerModel = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBody()
        setupNotificationObservers()
        addTapGesture()
        handleEditTextFiled()
        setupRegistrationViewModelObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDismissKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func setupRegistrationViewModelObserver() {
        registerModel.isFormValidObserver = { [weak self] isFormValid in
            
            guard let self = self else { return }
            
            self.body.registerButton.isEnabled = isFormValid
            
            if isFormValid {
                self.enableOrDisableRegisterButton(backgroundColor: #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1), titleColor: .white)
            } else {
                self.enableOrDisableRegisterButton(backgroundColor: .gray, titleColor: .lightGray)
            }
        }
    }
    
    fileprivate func enableOrDisableRegisterButton(backgroundColor: UIColor, titleColor: UIColor) {
        self.body.registerButton.backgroundColor = backgroundColor
        self.body.registerButton.setTitleColor(titleColor, for: .normal)
    }
    
    @objc
    fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        let bottomSpace = view.frame.height - body.stackView.frame.origin.y - body.stackView.frame.height
        
        let differance = keyboardFrame.height - bottomSpace
        
        self.view.transform = CGAffineTransform(translationX: 0, y: -differance - 8)
        
    }
    
    fileprivate func addTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    @objc
    fileprivate func handleDismissKeyboard() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            self?.view.transform = .identity
        }
    }
}

// MARK: -- Configure Body View
extension RegistrationVC {
    fileprivate func configureBody() {
        view.addSubview(body)
        body.fillSuperview()
    }
}

// MARK: -- Handle Editing TextFiled
extension RegistrationVC {
    fileprivate func handleEditTextFiled() {
        body.didEditTextFiled = { [weak self] textfiled in
            self?.handleChangeTextFiled(textfiled)
        }
    }
    
    fileprivate func handleChangeTextFiled(_ textfiled: UITextField) {
        if textfiled == body.fullNameTextField {
            registerModel.fullName = textfiled.text
        } else if textfiled == body.emailTextField {
            registerModel.email = textfiled.text
        } else {
            registerModel.password = textfiled.text
        }
    }
}
