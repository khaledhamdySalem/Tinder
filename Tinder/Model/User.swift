//
//  User.swift
//  Tinder
//
//  Created by KH on 26/08/2022.
//

import UIKit

struct User: ProducerCardViewModel {
    
    
    let name: String
    let age: Int
    let profession: String
    let imageName: [String]
    
    func getAttributeText() -> NSAttributedString {
        let textAttribute = NSMutableAttributedString(string: name, attributes: [.font: UIFont.boldSystemFont(ofSize: 32)])
        textAttribute.append(NSAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .light)]))
        textAttribute.append(NSAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.boldSystemFont(ofSize: 32)]))
        return textAttribute
    }
    
    func toCardViewModel() -> CardViewModel {
        .init(imageNames: imageName, attributeString: getAttributeText(), textAlighmrnt: .left)
    }
    
}
