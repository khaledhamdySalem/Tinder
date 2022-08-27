//
//  RegistrationBody.swift
//  Tinder
//
//  Created by KH on 26/08/2022.
//

import UIKit

class RegistrationBody: UIView {
    
    // Clousre
    var didEditTextFiled: ((UITextField) -> Void)?
    var didTabOnRegisterButton: (() -> Void)?
    var didTabOnSelectPhotoButton: (() -> Void)?
    // UI Components
   
    lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleEditText), for: .editingChanged)
        tf.tag = 0
        return tf
    }()
    
    lazy var emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleEditText), for: .editingChanged)
        tf.tag = 1
        return tf
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleEditText), for: .editingChanged)
        tf.tag = 2
        return tf
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = .gray
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    fileprivate let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGradientLayer()
        configureStackView()
    }
        
    lazy var stackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        fullNameTextField,
        emailTextField,
        passwordTextField,
        registerButton
    ])
    
    fileprivate func configureStackView() {        
        addSubview(stackView)
        stackView.spacing = 8
        stackView.axis = .vertical
        
        
        stackView.anchor(top: nil,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor, padding: .init(top: 0,
                                                                  left: 50,
                                                                  bottom: 0,
                                                                  right: 50))
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    fileprivate func addGradientLayer() {
        gradientLayer.colors = [#colorLiteral(red: 0.9830927253, green: 0.3620409966, blue: 0.3662127256, alpha: 1).cgColor, #colorLiteral(red: 0.89445436, green: 0.1296491921, blue: 0.4437102377, alpha: 1).cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    fileprivate func handleEditText(textfiled: UITextField) {
        didEditTextFiled?(textfiled)
    }
    
    @objc
    fileprivate func handleRegister() {
        didTabOnRegisterButton?()
    }
    
    @objc
    fileprivate func handleSelectPhoto() {
        didTabOnSelectPhotoButton?()
    }
}
