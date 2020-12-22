//
//  HomeViewModal.swift
//  Apptunix
//
//  Created by Arpit Garg on 18/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeViewModal: NSObject {
    
    var items = [HomeViewModalItem]()
    
    func getValue( jsonData: JSON, completion: ((_ data: Bool) -> Void) ) {
        
        guard let data =  HomeModal(data: jsonData) else {
            completion(false)
            return
        }
        
        items.removeAll()
        
        if !data.categories.isEmpty {
            let categories = HomeViewModalCategoryItem(categories: data.categories)
            self.items.append(categories)
        }
       
        if !data.saved.isEmpty {
            let saved = HomeViewModalRestaurantItem(items: data.saved, type: .saved)
            self.items.append(saved)
        }
       
        if !data.bestOffers.isEmpty {
            let bestOffers = HomeViewModalRestaurantItem(items: data.bestOffers, type: .bestOffers)
            self.items.append(bestOffers)
        }
        
        if !data.recommended.isEmpty {
            let recommended = HomeViewModalRestaurantItem(items: data.recommended, type: .recommended)
            self.items.append(recommended)
        }
   
       completion(true)
   }
}

extension HomeViewModal:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        if item.type == .categories {
            if let item = item as? HomeViewModalCategoryItem, let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell {
                cell.items = item.categories
                cell.selectionStyle = .none
                print("wrong everything is wrong", indexPath.row, indexPath.section)
                return cell
            } else {
                return UITableViewCell()
            }
        }else{
            if let item = item as? HomeViewModalRestaurantItem, let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier) as? RestaurantTableViewCell {
                cell.items = item.items
                cell.selectionStyle = .none
                print("right everything is right")
                return cell
            } else {
                print("wrong something is wrong")
                return UITableViewCell()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].tableRowCount
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch items[section].type {
        case .bestOffers:
            return "BestOffers"
        case .categories:
            return "Category"
        case .recommended:
            return "Recommended"
        case .saved:
            return "Saved Restaurants"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppSizes.SCREENWIDTH / 2
    }
}

enum HomeType {
    case categories
    case saved
    case bestOffers
    case recommended
}

struct HomeViewModalRestaurantItem: HomeViewModalItem {
    var type: HomeType
    var items: [RestaurantSet]
    
    var tableRowCount: Int {
        return 1
    }
    
    var collectionRowCount: Int {
        return items.count
    }
    
    init(items: [RestaurantSet], type:HomeType ) {
        self.items = items
        self.type = type
    }
}

struct HomeViewModalCategoryItem: HomeViewModalItem {
    var type: HomeType {
        return .categories
    }
    
    var tableRowCount: Int {
        return 1
    }
    
    var collectionRowCount: Int {
        return categories.count
    }
    
    var categories: [CategorySet]
    
    init(categories: [CategorySet] ) {
        self.categories = categories
    }
}

protocol HomeViewModalItem {
    var type: HomeType { get }
    var tableRowCount: Int { get }
    var collectionRowCount: Int { get }
}
