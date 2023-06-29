//
//  Restaurant.swift
//  Gusto
//
//  Created by Chris Ameter on 6/27/23.
//

import Foundation
// step 1
import SwiftData

// step 2
@Model class Restaurant {
    var name: String
    var priceRating: Int
    var qualityRating: Int
    var speedRating: Int
    // adding @Relationship(.cascade) causes a cascade delete, which means when you
    // delete a restaurant, it will also delete all it's dishes.  By default, it would
    // leave them all hanging around.
    @Relationship(.cascade) var dishes: [Dish]
    
    init(name: String, priceRating: Int, qualityRating: Int, speedRating: Int) {
        self.name = name
        self.priceRating = priceRating
        self.qualityRating = qualityRating
        self.speedRating = speedRating
        self.dishes = []
    }
}

@Model class Dish {
    var name: String
    var review: String
    
    init(name: String, review: String) {
        self.name = name
        self.review = review
    }
}
