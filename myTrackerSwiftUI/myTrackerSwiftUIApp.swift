//
//  myTrackerSwiftUIApp.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import SwiftUI
import SwiftData

@main
struct myTrackerSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DayData.self)
    }
}
