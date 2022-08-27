//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by KH on 27/08/2022.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

struct RegistrationViewModel {
    
    var binableImage = Bindable<UIImage>()
    var binableRegistering = Bindable<Bool>()
    var isFormValidObserver: ((Bool) -> Void)?
    
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
    var password: String? {
        didSet {
            checkValidity()
        }
    }
    
    func performRegistrating(complition: @escaping (Error?) -> ()) {
        guard let email = email, let pass = password else { return }
    
        Auth.auth().createUser(withEmail: email, password: pass) { res, err in
           
            if let err = err {
                complition(err)
                return
            }
            
            print("Reigster is done", res?.user.uid ?? "")
            
            // Upload Image to Storage
            let fileName = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
            let imageData = binableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            ref.putData(imageData, metadata: nil) { _, err in
               
                if let err = err {
                    complition(err)
                    return
                }
                
                print("Finished uploading image to storage")
                
                ref.downloadURL { url, err in
                    if let err = err {
                        complition(err)
                        return
                    }
                    
                    binableRegistering.value = false
                    print(url?.absoluteURL ?? "")
                }
            }
        }
    }
    
    func checkValidity() {
        let isValidForm = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isValidForm)
    }
    
}
