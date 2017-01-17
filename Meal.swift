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
        
        // initialization should fail if there is no name or if the rating is negative
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}
