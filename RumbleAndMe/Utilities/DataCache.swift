//
//  DataCache.swift
//  RumbleAndMe
//
//  Created by Muthuraj Muthulingam on 28/01/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit

final class DataCache {
    
    static let shared: DataCache = DataCache()
    
    private var cache: NSCache = NSCache<NSString, UIImage>()
    
    func store(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func retrive(imageFor key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
