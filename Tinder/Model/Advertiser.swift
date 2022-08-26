//
//  Advertiser.swift
//  Tinder
//
//  Created by KH on 26/08/2022.
//

import UIKit

struct Advertiser: ProducerCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: [String]
    
    func getAttributeText() -> NSAttributedString {
        let textAttribute = NSMutableAttributedString(string: title, attributes: [.font: UIFont.boldSystemFont(ofSize: 34)])
        
        textAttribute.append(NSAttributedString(string: "\n\(brandName)", attributes: [.font: UIFont.boldSystemFont(ofSize: 24)]))
        return textAttribute
    }
    
    func toCardViewModel() -> CardViewModel {
        .init(imageNames: posterPhotoName,
              attributeString: getAttributeText(),
              textAlighmrnt: .center)
    }
}
