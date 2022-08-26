//
//  ViewController.swift
//  Tinder
//
//  Created by KH on 23/08/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    let topStackView = HomeTopStackView()
    let cardDeckView = UIView()
    let bottomStackView = HomeBottomStackView()
 
    let cardViewModels: [CardViewModel] = {
        let producers: [ProducerCardViewModel] = [
            User(name: "Jane", age: 32, profession: "DJ ", imageName: ["jane1", "jane2", "jane3"]),
            User(name: "kelly", age: 23, profession: "IOS Dev", imageName: ["kelly1", "kelly2", "kelly3"]),
            Advertiser(title: "Job Name", brandName: "This is the best job for me", posterPhotoName: ["slide_out_menu_poster"])
        ]
        
        let models = producers.map({$0.toCardViewModel()})
        return models
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setupDummyCards()
        handleProfileAction()
    }
    
    fileprivate func handleProfileAction() {
        topStackView.profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)

    }
    
    @objc
    fileprivate func openProfile() {
        let vc = RegistrationVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    fileprivate func setupDummyCards() {
        
        cardViewModels.forEach { cardVM in
            let cardView = CardView(frame: .zero)
            cardView.card = cardVM
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setLayout() {
        let verticalStack = UIStackView(arrangedSubviews: [
            topStackView,
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
