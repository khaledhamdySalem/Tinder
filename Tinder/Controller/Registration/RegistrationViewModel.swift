//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by KH on 27/08/2022.
//

import UIKit

struct RegistrationViewModel {
 
    var fullName: String? {
        didSet {
            checkValidity()
        }
    }
    var email: String? {
        didSet {
            checkValidity()
        }
    }
    var  password: String? {
        didSet {
            checkValidity()
        }
    }
    
    var isFormValidObserver: ((Bool) -> Void)?
    func checkValidity() {
        let isValidForm = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isValidForm)
    }
    
}
