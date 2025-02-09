//
//  Day.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import Foundation
import SwiftData

class DayDataMapper {
    static func map(dayData: DayData) -> (name: String, identifier: UUID, exercises: [Exercise]) {
        let name = dayData.name
        let identifier = dayData.identifier
        let exercises = dayData.exercises.map { Exercise(exerciseData: $0)}
        
        return (name, identifier, exercises)
    }
}

class Day: Identifiable, ObservableObject {

    var name : String
    var identifier = UUID()
    var exercises = [Exercise]()
    
    init(name: String, identifier: UUID, exercises: [Exercise]) {
        self.name = name
        self.identifier = identifier
        self.exercises = exercises
    }
    
    convenience init(dayData: DayData) {
        let mappedData = DayDataMapper.map(dayData: dayData)
        self.init(name: mappedData.name, identifier: mappedData.identifier, exercises: mappedData.exercises)
    }
    /*
    convenience init(dayData: DayData) {
        self.init(name: dayData.name, identifier: dayData.identifier,
                  exercises: dayData.exercises.map { Exercise(exerciseData: $0)}
        )
    }
    */
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
    convenience init(day: Day){
        self.init(name: day.name, identifier: day.identifier,
                  exercises: day.exercises.map {ExerciseData(exercise: $0)}
        )
    }
}
