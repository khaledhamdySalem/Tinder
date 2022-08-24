//
//  CardView.swift
//  Tinder
//
//  Created by KH on 24/08/2022.
//

import UIKit

class CardView: UIView {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
