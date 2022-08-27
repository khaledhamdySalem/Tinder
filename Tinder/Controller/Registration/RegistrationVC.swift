//
//  RegistrationController.swift
//  Tinder
//
//  Created by KH on 26/08/2022.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import JGProgressHUD

class RegistrationVC: UIViewController {
    
    // MARK: -- View
    let body = RegistrationBody()
    var registerModel = RegistrationViewModel()
    
    // MARK: -- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBody()
        setupNotificationObservers()
        addTapGesture()
        setActions()
        setupRegistrationViewModelObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
        
        registerModel.binableImage.bind { [weak self] image in
            self?.body.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        registerModel.binableRegistering.bind { [weak self] isRegister in
            if isRegister == true {
                self?.registerHUD.textLabel.text = "Register"
                self?.registerHUD.show(in: self?.view ?? UIView())
            } else {
                self?.registerHUD.dismiss()
            }
        }
    }
    
    fileprivate func enableOrDisableRegisterButton(backgroundColor: UIColor, titleColor: UIColor) {
        self.body.registerButton.backgroundColor = backgroundColor
        self.body.registerButton.setTitleColor(titleColor, for: .normal)
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDismissKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    // MARK: -- Handle Edit TextFiled
    fileprivate func handleChangeTextFiled(_ textfiled: UITextField) {
        if textfiled == body.fullNameTextField {
            registerModel.fullName = textfiled.text
        } else if textfiled == body.emailTextField {
            registerModel.email = textfiled.text
        } else {
            registerModel.password = textfiled.text
        }
    }
    
    // MARK: --
    fileprivate func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    let registerHUD =  JGProgressHUD(style: .dark)
    
    // MARK: --  Handle Register Button Action
    fileprivate func handleRegisterAction() {
        handleDismissKeyboard()
        registerModel.binableRegistering.value = true
        registerModel.performRegistrating { [weak self] err in
            if let err = err {
                self?.showHUDWithError(error: err)
                return
            }
        }
    }
    
    fileprivate func showHUDWithError(error: Error) {
        registerHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
}

// MARK: -- Configure Body View
extension RegistrationVC {
    fileprivate func configureBody() {
        view.addSubview(body)
        body.fillSuperview()
    }
}

// MARK: -- SetActions
extension RegistrationVC {
    fileprivate func setActions() {
        body.didEditTextFiled = { [weak self] textfiled in
            self?.handleChangeTextFiled(textfiled)
        }
        
        body.didTabOnRegisterButton = { [weak self] in
            self?.handleRegisterAction()
        }
        
        body.didTabOnSelectPhotoButton = { [weak self] in
            self?.handleSelectPhoto()
        }
    }
}

// MARK: -- PickerImage Delegate
extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        registerModel.binableImage.value = image
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
