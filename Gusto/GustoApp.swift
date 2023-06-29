//
//  GustoApp.swift
//  Gusto
//
//  Created by Chris Ameter on 6/27/23.
//

import SwiftUI
// step 3
import SwiftData

@main
struct GustoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // step 4
        .modelContainer(for: Restaurant.self)
    }
}
