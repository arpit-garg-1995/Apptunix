//
//  HomeModal.swift
//  Apptunix
//
//  Created by Arpit Garg on 19/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HomeModal {
    var categories = [CategorySet]()
    var saved = [RestaurantSet]()
    var bestOffers = [RestaurantSet]()
    var recommended = [RestaurantSet]()
    init?(data: JSON) {
        
        
        
        if data["categories"] != JSON.null {
            if let array = data["categories"].array {
                if array.count > 0 {
                    self.categories = array.map { CategorySet(data: $0) }
                }
            }
        }
        
        if data["saved"] != JSON.null {
            if let array = data["saved"].array {
                if array.count > 0 {
                    self.saved = array.map {RestaurantSet(data: $0)}
                }
            }
        }
        
        if data["bestOffers"] != JSON.null {
            if let array = data["bestOffers"].array {
                if array.count > 0 {
                    self.bestOffers = array.map {RestaurantSet(data: $0)}
                }
            }
        }
        
        if data["recommended"] != JSON.null && UserDefaults.standard.bool(forKey: "first"){
            if let array = data["recommended"].array {
                if array.count > 0 {
                    self.recommended = array.map {RestaurantSet(data: $0)}
                }
            }
        }else{
            UserDefaults.standard.set(true, forKey: "first")
        }
    }
}


struct CategorySet {
    var id:String!
    var name:String!
    var imagePath:String!
    var restaurants:Int!
    init(data: JSON) {
        self.imagePath = data["image"].stringValue
        self.name = data["name"].stringValue
        self.restaurants = data["restaurants"].intValue
        self.id = data["_id"].stringValue
    }
}

struct RestaurantSet {
    var id:String!
    var name:String!
    var imagePath:String!
    var rating:Double!
    var reviewsCount:Int!
    var deliveryTime:Int!
    var discount:Int!
    init(data: JSON) {
        self.imagePath = data["image"].stringValue
        self.name = data["name"].stringValue
        self.rating = data["ratings"].doubleValue
        self.reviewsCount = data["ratingCount"].intValue
        self.id = data["_id"].stringValue
        self.discount = data["discountUpto"].intValue
        self.deliveryTime = data["avgDeliveryTime"].intValue
    }
}
