//
//  EditRestaurantView.swift
//  Gusto
//
//  Created by Chris Ameter on 6/27/23.
//

import SwiftUI
import SwiftData

struct EditRestaurantView: View {
    @Bindable var restaurant: Restaurant
    
    @State private var showingDishAlert = false
    @State private var dishName = ""
    @State private var dishReview = ""
    
    var body: some View {
        
        Form {
            TextField("Name of restaurant", text: $restaurant.name)
            
            Section("Ratings") {
                Picker("Price", selection: $restaurant.priceRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }
                
                Picker("Quality", selection: $restaurant.qualityRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }
                
                Picker("Speed", selection: $restaurant.speedRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }
            }
            
            Section {
                ForEach(restaurant.dishes) { dish in
                    Text(dish.name)
                }
            }
        }
        .toolbar {
            Button("Add Dish") {
                showingDishAlert.toggle()
            }
        }
        .alert("Add a new dish", isPresented: $showingDishAlert) {
            TextField("Dish name", text: $dishName)
            TextField("Your review", text: $dishReview)
            
            Button("OK", action: createDish)
            Button("Cancel", role: .cancel) { }
        }
    }
    
    func createDish() {
        let dish = Dish(name: dishName, review: dishReview)
        restaurant.dishes.append(dish)
    }
}

//#Preview {
//    EditRestaurantView()
//}

struct EditRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: Restaurant.self, config)
        
        let restaurant = Restaurant(name: "Example Data Here", priceRating: 1, qualityRating: 2, speedRating: 3)
        
        EditRestaurantView(restaurant: restaurant)
            .modelContainer(container)
    }
}
