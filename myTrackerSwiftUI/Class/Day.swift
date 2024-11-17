//
//  Day.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import Foundation

class Day: Identifiable {

    var name : String
    var identifier = UUID()
    var exercises : [Exercise]
    
    init(name: String, identifier: UUID, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
        self.identifier = identifier
    }
}
