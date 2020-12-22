//
//  CategoryCollectionViewCell.swift
//  Apptunix
//
//  Created by Arpit Garg on 19/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cImage: UIImageView!
    @IBOutlet weak var cLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var nib: UINib {
           return UINib(nibName: identifier, bundle: nil)
       }

       static var identifier: String {
           return String(describing: self)
       }
    
    var categoryItem: CategorySet! {
        didSet {
            self.cImage.setImage(imageUrl: categoryItem.imagePath!)
            self.cLabel.text = categoryItem.name + "(\(categoryItem.restaurants!))"
        }

    }

}
