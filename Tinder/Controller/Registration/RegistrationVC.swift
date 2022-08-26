//
//  RegistrationController.swift
//  Tinder
//
//  Created by KH on 26/08/2022.
//

import UIKit

class RegistrationVC: UIViewController {

    let body = RegistrationBody()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBody()
        setupNotificationObservers()
        addTapGesture()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: -- Configure Body View
extension RegistrationVC {
    fileprivate func configureBody() {
        view.addSubview(body)
        body.fillSuperview()
    }
}
