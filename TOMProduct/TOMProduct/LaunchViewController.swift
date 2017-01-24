//
//  LaunchViewController.swift
//  TOMProduct
//
//  Created by Anoop tomar on 1/21/17.
//  Copyright © 2017 Devtechie. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {

    lazy var splashView: SplashView = {
        let s = SplashView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.24, green:0.24, blue:0.24, alpha:1.0)
        self.view.addSubview(splashView)
        
        NSLayoutConstraint.activate([
            splashView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            splashView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            splashView.topAnchor.constraint(equalTo: self.view.topAnchor),
            splashView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        UIView.animate(withDuration: 0.3, delay: 4.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            [weak self] in
            self?.splashView.alpha = 0.0
        }) { [weak self] (finished) in
            self?.present(UINavigationController(rootViewController: HomeViewController()), animated: true, completion: nil)
        }
    }
}
