//
//  ServerManager.swift
//  TOMProduct
//
//  Created by Anoop tomar on 1/21/17.
//  Copyright © 2017 Devtechie. All rights reserved.
//

import Foundation
class ServerManager {
    
    static let shared = ServerManager()
    
    private init() {}
    
    func getProducts(completion: @escaping (([Product]?) -> Void)) {
        do {
            let payload: [String: Any] = ["requestDate": Date.today()]
            let payloadData = try JSONSerialization.data(withJSONObject: payload)
            var request = URLRequest(url: URL(string: "https://public.touchofmodern.com/ioschallenge.json")!)
            request.httpMethod = "POST"
            request.httpBody = payloadData
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let responseData = data, error == nil else {
                    print(error?.localizedDescription ?? "Nothing to show")
                    return
                }
                do{
                    if let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String: Any]] {
                        var products = [Product]()
                        for obj in jsonObject {
                            let product = Product()
                            product.setValuesForKeys(obj)
                            products.append(product)
                        }
                        completion(products)
                    }
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }).resume()
            
        }catch {
            print(error.localizedDescription)
        }
    }
}
