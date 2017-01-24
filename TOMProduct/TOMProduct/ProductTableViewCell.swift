//
//  ProductTableViewCell.swift
//  TOMProduct
//
//  Created by Anoop tomar on 1/22/17.
//  Copyright © 2017 Devtechie. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    var showingDetails = false
    
    lazy var backgroundImage: CustomImageView = {
        let b = CustomImageView()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.contentMode = .scaleAspectFill
        return b
    }()
    
    lazy var descView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        return v
    }()
    
    lazy var name: UILabel = {
        let n = UILabel()
        n.translatesAutoresizingMaskIntoConstraints = false
        n.text = "Product Name"
        n.font = UIFont.systemFont(ofSize: 15)
        n.textColor = UIColor.white
        return n
    }()
    
    lazy var price: UILabel = {
        let p = UILabel()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.text = "Product Name"
        p.font = UIFont.systemFont(ofSize: 15)
        p.textColor = UIColor.white
        p.textAlignment = .right
        return p
    }()
    
    lazy var descLabel: UITextView = {
        let l = UITextView()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isEditable = false
        l.font = UIFont.systemFont(ofSize: 10)
        l.textColor = UIColor.white
        l.isScrollEnabled = true
        l.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        l.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        l.layer.cornerRadius = 2
        l.showsHorizontalScrollIndicator = false
        return l
    }()
    
    var product: Product? {
        didSet {
            if let p = product {
                backgroundImage.loadImageUsingUrlString(urlString: p.image!)
                name.text = p.name!
                price.text = p.price!.getCurrencyString()
                descLabel.text = p.desc!
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(backgroundImage)
        self.addSubview(descView)
        descView.addSubview(name)
        descView.addSubview(price)
        descView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 50),
            descView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            descView.heightAnchor.constraint(equalToConstant: 100),
            name.leadingAnchor.constraint(equalTo: descView.leadingAnchor, constant: 8),
            name.topAnchor.constraint(equalTo: descView.topAnchor, constant: 8),
            price.trailingAnchor.constraint(equalTo: descView.trailingAnchor, constant: -8),
            price.topAnchor.constraint(equalTo: descView.topAnchor, constant: 8),
            descLabel.leadingAnchor.constraint(equalTo: descView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: descView.trailingAnchor),
            descLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            descLabel.bottomAnchor.constraint(equalTo: descView.bottomAnchor, constant: -8)
        ])
        backgroundImage.clipsToBounds = true
    }
   
    func cellOnTableView(tableView:UITableView, didScrollOnView:UIView) {
        let rectInSuperView = tableView.convert(self.frame, to: didScrollOnView)
        let distanceFromCenter: CGFloat = didScrollOnView.frame.height / CGFloat(2) - rectInSuperView.minY
        let difference = backgroundImage.frame.height - self.frame.height
        let move = (distanceFromCenter / didScrollOnView.frame.height) * difference
        
        var imageRect = self.backgroundImage.frame
        imageRect.origin.y = -(difference / 2 ) + move
        self.backgroundImage.frame = imageRect
        self.backgroundImage.clipsToBounds = true
        
    }

    override func prepareForReuse() {
        self.backgroundImage.image = nil
        
    }
}
