//
//  AppExtensions.swift
//  Apptunix
//
//  Created by Arpit Garg on 19/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension String {
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
   
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
}

extension UIImageView {
    
    func setImage(imageUrl: String ) {
        
        ImageCache.default.maxDiskCacheSize = 30 * 1024 * 1024
        let url = AppCredentials.BASEURL + imageUrl
        if URL(string: url) != nil && imageUrl.count > 0 {
            let resource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
            self.contentMode = .scaleAspectFit
            self.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
