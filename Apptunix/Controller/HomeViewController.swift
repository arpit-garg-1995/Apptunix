//
//  HomeViewController.swift
//  Apptunix
//
//  Created by Arpit Garg on 19/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    var jsonData: JSON!
    fileprivate let homeViewModalObject = HomeViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        homeTableView.separatorStyle = .none
        self.registerNib()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        setTableViewData()
    }
    
    func setTableViewData() {
        self.homeViewModalObject.getValue(jsonData: jsonData) { [weak self] (data: Bool) in
            if data {
                homeTableView.dataSource =  homeViewModalObject
                homeTableView.delegate =  homeViewModalObject
                self?.homeTableView.reloadData()
            }
        }
    }
    
    func registerNib(){
        homeTableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        homeTableView.register(RestaurantTableViewCell.nib, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
    }

}
