//
//  Meal.swift
//  foodtracker
//
//  Created by Amy Qian on 1/12/17.
//  Copyright © 2017 Amy Qian. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    // MARK: properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: archiving paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    // MARK: initialization
    
    init?(name: String, photo: UIImage, rating: Int) {
        
        // initialize stored properties
        
        self.name = name
        self.photo = photo
        self.rating = rating
        
        // name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // rating must be between 0 and 5 inclusive
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(name, forKey: PropertyKey.photo)
        aCoder.encode(name, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // the name is required. if we cannot decode a name string, the initializer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else {
                os_log("Unable to decode the name for a Meal object", log: OSLog.default, type: .debug)
                return nil
        }
        
        // because photo is an optional property of Meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // must call designated initializer
        self.init(name: name, photo: photo!, rating: rating)
    }
}
