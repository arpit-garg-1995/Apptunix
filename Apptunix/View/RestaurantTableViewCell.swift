//
//  RestaurantTableViewCell.swift
//  Apptunix
//
//  Created by Arpit Garg on 19/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var rCollectionVIew: UICollectionView!
    var items = [RestaurantSet]()
    override func awakeFromNib() {
         super.awakeFromNib()
         rCollectionVIew.delegate = self
         rCollectionVIew.dataSource = self
         
         rCollectionVIew.register(RestaurantCollectionViewCell.nib, forCellWithReuseIdentifier: RestaurantCollectionViewCell.identifier)
         rCollectionVIew.backgroundColor = UIColor.white
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

         // Configure the view for the selected state
     }
     
     static var nib: UINib {
            return UINib(nibName: identifier, bundle: nil)
        }
        
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension RestaurantTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.identifier, for: indexPath as IndexPath) as? RestaurantCollectionViewCell {
                  cell.restaurantItem = items[indexPath.row]
                  cell.clipsToBounds = true
                  cell.layer.masksToBounds = false
                  return cell
              } else {
                  return UICollectionViewCell()
              }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 176, height: 252)
    }
}
