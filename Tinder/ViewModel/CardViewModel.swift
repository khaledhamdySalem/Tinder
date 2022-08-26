//
//  CardViewModel.swift
//  Tinder
//
//  Created by KH on 26/08/2022.
//

import UIKit

protocol ProducerCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    let imageNames: [String]
    let attributeString: NSAttributedString
    let textAlighmrnt: NSTextAlignment
    
    init(imageNames: [String], attributeString: NSAttributedString, textAlighmrnt: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributeString = attributeString
        self.textAlighmrnt = textAlighmrnt
    }
    
    var imageIndexObserval: ((Int, UIImage?) -> ())?
    var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserval?(imageIndex, image)
        }
    }
    
    func goToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviosPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
