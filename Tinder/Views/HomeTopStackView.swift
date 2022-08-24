//
//  HomeTopStackView.swift
//  Tinder
//
//  Created by KH on 24/08/2022.
//

import UIKit

class HomeTopStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let subViews = [#imageLiteral(resourceName: "03_6"), #imageLiteral(resourceName: "03_7.png"), #imageLiteral(resourceName: "03_8.png")].map { img -> UIButton in
            let v = UIButton(type: .system)
            v.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            return v
        }
        
        subViews.forEach { v in
            addArrangedSubview(v)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
