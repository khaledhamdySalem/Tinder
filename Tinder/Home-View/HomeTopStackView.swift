//
//  HomeTopStackView.swift
//  Tinder
//
//  Created by KH on 24/08/2022.
//

import UIKit

class HomeTopStackView: UIStackView {
    
    let profileButton: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
 
    let fireImage = UIImageView(image: #imageLiteral(resourceName: "03_7.png"))
  
    let messageButton: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        distribution = .equalCentering
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        profileButton.setImage(#imageLiteral(resourceName: "03_6.png").withRenderingMode(.alwaysOriginal), for: .normal)
       
        messageButton.setImage(#imageLiteral(resourceName: "03_8.png").withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        
        [profileButton, fireImage, messageButton].forEach { v in
            addArrangedSubview(v)
        }
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
