//
//  SplashView.swift
//  TOMProduct
//
//  Created by Anoop tomar on 1/21/17.
//  Copyright © 2017 Devtechie. All rights reserved.
//

import UIKit

class SplashView: UIView {
    
    lazy var textTitle: UILabel = {
        let l = UILabel()//frame: CGRect(x:0,y:0,width: self.bounds.width,height:200))
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Touch Of Modern"
        l.textColor = UIColor.white
        l.font = UIFont.systemFont(ofSize: 42)
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(textTitle)
        
        NSLayoutConstraint.activate([
            textTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        addGradientMaskToView(view: textTitle)
    }
    
    
    func addGradientMaskToView(view:UILabel, transparency:CGFloat = 0.5, gradientWidth:CGFloat = 30.0) {
        let gradientMask = CAGradientLayer()
        gradientMask.frame = view.bounds
        let gradientSize = gradientWidth/view.frame.size.width
        let gradientColor = UIColor(white: 1, alpha: transparency)
        let startLocations = [0, gradientSize/2, gradientSize]
        let endLocations = [(1 - gradientSize), (1 - gradientSize/2), 1]
        let animation = CABasicAnimation(keyPath: "locations")
        
        gradientMask.colors = [gradientColor.cgColor, UIColor.white.cgColor, gradientColor.cgColor]
        gradientMask.locations = startLocations as [NSNumber]?
        gradientMask.startPoint = CGPoint(x:0 - (gradientSize * 2), y: 0.5)
        gradientMask.endPoint = CGPoint(x:1 + gradientSize, y: 0.5)
        
        view.layer.mask = gradientMask
        
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.repeatCount = HUGE
        animation.duration = 2
        
        gradientMask.add(animation, forKey: nil)
    }
}

