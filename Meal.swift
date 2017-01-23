//
//  Meal.swift
//  foodtracker
//
//  Created by Amy Qian on 1/12/17.
//  Copyright © 2017 Amy Qian. All rights reserved.
//

import UIKit

class Meal {
    
    // MARK: properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
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
}
