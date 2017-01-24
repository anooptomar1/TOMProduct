//
//  CustomImageView.swift
//  TOMProduct
//
//  Created by Anoop tomar on 1/23/17.
//  Copyright © 2017 Devtechie. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var imageUrl: String?
    
    func loadImageUsingUrlString(urlString: String) {
        imageUrl = urlString
        let url = URL(string: urlString)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.image = nil
        
        if let imageCache = appDelegate.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { [weak self] (data, response, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                if let urlStr = self?.imageUrl {
                    if urlStr == urlString {
                        let imageToCache = UIImage(data: data!)
                        appDelegate.imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        self?.image = imageToCache
                    }
                }
            }
            }.resume()
    }
}
