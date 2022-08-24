//
//  HomeBottomStackView.swift
//  Tinder
//
//  Created by KH on 24/08/2022.
//

import UIKit

class HomeBottomStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        getStackView()
    }
    
    fileprivate func getStackView() {
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let subViews = [#imageLiteral(resourceName: "03_1"), #imageLiteral(resourceName: "03_2.png"), #imageLiteral(resourceName: "03_3.png"), #imageLiteral(resourceName: "03_4.png"), #imageLiteral(resourceName: "03_5.png")].map { img -> UIButton in
            let btn = UIButton(type: .system)
            btn.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            return btn
        }
        
        subViews.forEach { v in
            addArrangedSubview(v)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
