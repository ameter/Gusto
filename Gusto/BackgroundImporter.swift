//
//  BackgroundImporter.swift
//  Gusto
//
//  Created by Chris Ameter on 6/28/23.
//

import SwiftData

actor BackgroundImporter {
    var modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func backgroundImporterBad() throws {
        let modelContext = ModelContext(modelContainer)
        
        for _ in 0..<100_000 {
            let newRestaurant = Restaurant(name: "Whatever", priceRating: 1, qualityRating: 1, speedRating: 1)
            modelContext.insert(newRestaurant)
        }
        
        try modelContext.save()
    }
    
    func backgroundImporterGood() throws {
        let modelContext = ModelContext(modelContainer)
        
        let batchSize = 1000
        let totalObjects = 100_000
        
        for _ in 0..<(totalObjects / batchSize) {
            for _ in 0..<batchSize {
                let newRestaurant = Restaurant(name: "Whatever", priceRating: 1, qualityRating: 1, speedRating: 1)
                modelContext.insert(newRestaurant)
            }
            
            try modelContext.save()
        }
    }
}
