//
//  CardView.swift
//  Tinder
//
//  Created by KH on 24/08/2022.
//

import UIKit

class CardView: UIView {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let threshold: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
        configureView()
        addPanGestureToView()
    }
    
    fileprivate func configureView() {
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    fileprivate func configureImageView() {
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    fileprivate func addPanGestureToView() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc
    fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        @unknown default:
            ()
        }
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

        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) { [weak self] in
            self?.dismissVieworNot(gesture: gesture)
        } completion: { [weak self] _ in
            self?.transform = .identity
        }
    }
    
    fileprivate func dismissVieworNot(gesture: UIPanGestureRecognizer) {
        let shouldDismmCard = gesture.translation(in: nil).x > (threshold)

        if shouldDismmCard {
            self.transform = CGAffineTransform(translationX: 600, y: 0)
            
        } else {
            self.transform = .identity
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
