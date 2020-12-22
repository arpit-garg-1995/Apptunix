//
//  TableViewCell.swift
//  Apptunix
//
//  Created by Arpit Garg on 19/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tCollectionView: UICollectionView!
    var items = [CategorySet]()
    override func awakeFromNib() {
        
        super.awakeFromNib()
        tCollectionView.delegate = self
        tCollectionView.dataSource = self
        
        tCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        tCollectionView.backgroundColor = UIColor.white
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

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath as IndexPath) as? CategoryCollectionViewCell {
                  cell.categoryItem = items[indexPath.row]
                  cell.clipsToBounds = true
                  cell.layer.masksToBounds = false
                  return cell
              } else {
                  return UICollectionViewCell()
              }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 136, height: 204)
    }
}
