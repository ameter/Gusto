//
//  ContentView.swift
//  Gusto
//
//  Created by Chris Ameter on 6/27/23.
//

import SwiftUI
// step 5
import SwiftData

struct ContentView: View {
    // step 6
//    @Query(sort: \.name) var restaurants: [Restaurant]
//    @Query(sort: [SortDescriptor(\.priceRating, order: .reverse), SortDescriptor(\.name)]) var restaurants: [Restaurant]
    // step 7
    @Environment(\.modelContext) var modelContext
    
    @State private var navPath = [Restaurant]()
    
    @State private var sortOrder = SortDescriptor(\Restaurant.name)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                RestaurantListingView(sort: sortOrder, searchString: searchText)
            }
            .navigationDestination(for: Restaurant.self) { restaurant in
                EditRestaurantView(restaurant: restaurant)
            }
            .searchable(text: $searchText)
            .navigationTitle("Gusto")
            .toolbar {
                Button("Add Samples", action: addSamples)
                
                Button(action: addNewRestaurant) {
                    Label("Add new restaurant", systemImage: "plus")
                }
                
                Menu("Sort") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag(SortDescriptor(\Restaurant.name, order: .reverse))
                        
                        Text("Price")
                            .tag(SortDescriptor(\Restaurant.priceRating, order: .reverse))
                        
                        Text("Quality")
                            .tag(SortDescriptor(\Restaurant.qualityRating, order: .reverse))
                        
                        Text("Speed")
                            .tag(SortDescriptor(\Restaurant.speedRating, order: .reverse))
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
    
    func addSamples() {
        let a = Restaurant(name: "Wok this Way", priceRating: 5, qualityRating: 4, speedRating: 3)
        let b = Restaurant(name: "Thyme Square", priceRating: 3, qualityRating: 4, speedRating: 2)
        let c = Restaurant(name: "Pasta la Vista", priceRating: 4, qualityRating: 4, speedRating: 3)
        let d = Restaurant(name: "Life of Pie", priceRating: 3, qualityRating: 4, speedRating: 5)
        let e = Restaurant(name: "Lord of the Wings", priceRating: 5, qualityRating: 2, speedRating: 5)
        
        modelContext.insert(a)
        modelContext.insert(b)
        modelContext.insert(c)
        modelContext.insert(d)
        modelContext.insert(e)
    }
    
//    func deleteRestaurants(_ indexSet: IndexSet) {
//        for item in indexSet {
//            let object = restaurants[item]
//            modelContext.delete(object)
//        }
//    }
    
    func addNewRestaurant() {
        let newRestaurant = Restaurant(name: "New Restaurant", priceRating: 3, qualityRating: 3, speedRating: 3)
        modelContext.insert(newRestaurant)
        
        navPath = [newRestaurant]
    }
    
    func deleteAllRestaurants() {
        // batch operations will almost certainly (hopefully) change before final realease
        _ = try? modelContext.delete(model: Restaurant.self)
    }
}

#Preview {
    ContentView()
}
