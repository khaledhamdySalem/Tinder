//
//  ViewController.swift
//  Tinder
//
//  Created by KH on 23/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let horStackView = HomeTopStackView()
    let cardDeckView = UIView()
    let bottomStackView = HomeBottomStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setupDummyCards()
    }
    
    fileprivate func setupDummyCards() {
        let cardView = CardView(frame: .zero)
        cardDeckView.addSubview(cardView)
        cardView.fillSuperview()
    }
    
    fileprivate func setLayout() {
        let verticalStack = UIStackView(arrangedSubviews: [
            horStackView,
            cardDeckView,
            bottomStackView
        ])
        
        verticalStack.axis = .vertical
        view.addSubview(verticalStack)
        verticalStack.spacing = 8
        
        verticalStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        verticalStack.bringSubviewToFront(cardDeckView)
        
        verticalStack.isLayoutMarginsRelativeArrangement = true
        verticalStack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
    }
}
