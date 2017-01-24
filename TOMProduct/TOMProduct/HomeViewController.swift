//
//  HomeViewController.swift
//  TOMProduct
//
//  Created by Anoop tomar on 1/21/17.
//  Copyright © 2017 Devtechie. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let cellId = "Cell"
    
    var sortedAscending = false
    var sortButton : UIBarButtonItem!
    
    let parallaxOffsetSpeed: CGFloat = 30
    let cellHeight: CGFloat = 300
    
    var products = [Product]()
    
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * self.tableView.frame.height) - cellHeight) / 2
        return maxOffset + self.cellHeight
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        
        // load data
        ServerManager.shared.getProducts { [weak self](products) in
            self?.products = products!
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        //tableview
        self.view.addSubview(tableView)
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.black
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.viewConstraints()
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.5)
        self.title = "Today's Top Pick"
        sortButton = UIBarButtonItem(title: "⬇︎⬆︎", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeViewController.sortProduct))
        sortButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = sortButton
    }
    
    func sortProduct(){
        if sortedAscending {
            sortButton.title = "⬆︎"
            products.sort(by: { (p1, p2) -> Bool in
                return p1.price!.decimalValue < p2.price!.decimalValue
            })
            tableView.reloadData()
        }else {
            sortButton.title = "⬇︎"
            products.sort(by: { (p1, p2) -> Bool in
                return p1.price!.decimalValue > p2.price!.decimalValue
            })
            tableView.reloadData()
            
        }
        sortedAscending = !sortedAscending
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateTableCells()
    }
    
    func viewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor)
        ])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateTableCells()
    }
    
    func updateTableCells() {
        let visibleCells = self.tableView.visibleCells as! [ProductTableViewCell]
        for cell in visibleCells {
            cell.clipsToBounds = true
            cell.selectionStyle = .none
            cell.cellOnTableView(tableView: self.tableView, didScrollOnView: self.view)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductTableViewCell
        cell.product = products[indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.products.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        }
    }

    
}

