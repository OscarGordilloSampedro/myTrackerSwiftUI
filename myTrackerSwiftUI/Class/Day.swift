//
//  Day.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import Foundation
import SwiftData

class Day: Identifiable, ObservableObject {

    var name : String
    var identifier = UUID()
    var exercises = [Exercise]()
    
    init(name: String, identifier: UUID, exercises: [Exercise]) {
        self.name = name
        self.identifier = identifier
        self.exercises = exercises
    }
    
    init(dayData: DayData) {
            self.name = dayData.name
            self.identifier = dayData.identifier
            self.exercises = dayData.exercises.map { Exercise(exerciseData: $0) }
        }
}

@Model
class DayData {

    var name : String
    var identifier = UUID()
    var exercises = [ExerciseData]()
    
    init(name: String, identifier: UUID, exercises: [ExerciseData]) {
        self.name = name
        self.identifier = identifier
        self.exercises = exercises
    }
    init(day: Day){
        self.name = day.name
        self.exercises = day.exercises.map {ExerciseData(exercise: $0)}
        self.identifier = day.identifier
    }
}
