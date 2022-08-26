//
//  CardView.swift
//  Tinder
//
//  Created by KH on 24/08/2022.
//

import UIKit

class CardView: UIView {
    
    // MARK: -- Properties
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Test Test"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    fileprivate let barstackViews = UIStackView()
    fileprivate let unSelectedBarColor = UIColor.init(white: 0, alpha: 0.1)
    
    var card: CardViewModel! {
        didSet {
            let imageName = card.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = card.attributeString
            informationLabel.textAlignment = card.textAlighmrnt
            
            (0..<card.imageNames.count).forEach { _ in
                let v = UIView()
                v.backgroundColor = unSelectedBarColor
                barstackViews.addArrangedSubview(v)
            }
            
            barstackViews.arrangedSubviews.first?.backgroundColor = UIColor.white
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver() {
        card.imageIndexObserval = { [weak self] index, image in
            self?.showImageInView(image ?? UIImage())
            self?.setupBarView(index)
        }
    }
    
    fileprivate func showImageInView( _ image: UIImage) {
        imageView.image = image
        
    }
    
    fileprivate func setupBarView(_ index: Int) {
        barstackViews.arrangedSubviews.forEach({$0.backgroundColor = unSelectedBarColor})
        barstackViews.arrangedSubviews[index].backgroundColor = .white
    }
    
    // MARK: -- Configuration
    fileprivate let threshold: CGFloat = 100
    fileprivate var shouldDismmCard: Bool?
    
    // MARK: -- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
        setupBarStackView()
        addGradientLayer()
        configureInformationLabel()
        configureView()
        addPanGestureToView()
        addTabGestureToView()
    }
    
    fileprivate func addPanGestureToView() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc
    fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            handleChanged(gesture)
        }
        
        if gesture.state == .ended {
            handleEnded(gesture)
        }
    }
    
    fileprivate func addTabGestureToView() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    var indexImage = 0
    
    @objc
    fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width/2 ? true: false
        
        if shouldAdvanceNextPhoto {
            card.goToNextPhoto()
        } else {
            card.goToPreviosPhoto()
        }
    }
    
    fileprivate func configureImageView() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.fillSuperview()
    }
    
    fileprivate let gradientLayer = CAGradientLayer()
    
    fileprivate func configureInformationLabel() {
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    fileprivate func setupBarStackView() {
        addSubview(barstackViews)
        barstackViews.distribution = .fillEqually
        barstackViews.spacing = 4
        
        barstackViews.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 4))
    }
    
    fileprivate func addGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        calculateMovingAndTransformView(gesture)
    }
    
    fileprivate func calculateMovingAndTransformView(_ gesture: UIPanGestureRecognizer) {
        let translate = gesture.translation(in: .none)
        let degress = translate.x / 20
        let angle = degress * .pi / 180
        self.transform = CGAffineTransform(rotationAngle: angle).translatedBy(x: translate.x, y: translate.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) { [weak self] in
            self?.dismissVieworNot(gesture: gesture)
        } completion: { [weak self] _ in
            self?.transform = .identity
            if self?.shouldDismmCard == true {
                self?.removeFromSuperview()
            }
        }
    }
    
    fileprivate func dismissVieworNot(gesture: UIPanGestureRecognizer) {
        shouldDismmCard = gesture.translation(in: nil).x > (threshold)
        
        if shouldDismmCard == true {
            self.transform = CGAffineTransform(translationX: 600, y: 0)
            
        } else {
            self.transform = .identity
        }
    }
    
    fileprivate func configureView() {
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
