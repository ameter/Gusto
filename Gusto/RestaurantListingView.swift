//
//  RestaurantListingView.swift
//  Gusto
//
//  Created by Chris Ameter on 6/27/23.
//

import SwiftUI
import SwiftData

struct RestaurantListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\.priceRating, order: .reverse), SortDescriptor(\.name)]) var restaurants: [Restaurant]
    
    init(sort: SortDescriptor<Restaurant>, searchString: String = "") {
        _restaurants = Query(
            filter: #Predicate { restaurant in
                searchString.isEmpty || restaurant.name.contains(searchString)
            },
            sort: [sort]
        )
    }
    
    var body: some View {
        ForEach(restaurants) { restaurant in
            NavigationLink(value: restaurant) {
                VStack(alignment: .leading) {
                    Text(restaurant.name)
                    
                    HStack(spacing: 30) {
                        HStack {
                            Image(systemName: "dollarsign.circle")
                            Text(String(restaurant.priceRating))
                        }
                        
                        HStack {
                            Image(systemName: "hand.thumbsup")
                            Text(String(restaurant.qualityRating))
                        }
                        
                        HStack {
                            Image(systemName: "bolt")
                            Text(String(restaurant.speedRating))
                        }
                    }
                }
            }
        }
        .onDelete(perform: deleteRestaurants)
    }
    
    func deleteRestaurants(_ indexSet: IndexSet) {
        for item in indexSet {
            let object = restaurants[item]
            modelContext.delete(object)
        }
    }
}

#Preview {
    RestaurantListingView(sort: SortDescriptor(\.name))
}
