//
//  Exercise.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import Foundation
import SwiftData

class ExerciseDataMapper {
    static func map(exerciseData: ExerciseData) -> (name: Exercise.ExerciseType, sets: [ExerciseSet]) {
        let name = Exercise.ExerciseType(rawValue: exerciseData.name) ?? .squat
        let sets = exerciseData.sets.map { ExerciseSet(exerciseSetData: $0)}
        
        return(name, sets)
    }
}

class Exercise: Identifiable, ObservableObject {
    @Published var name: ExerciseType
    @Published var sets: [ExerciseSet]

    init(name: ExerciseType, sets: [ExerciseSet] = []) {
        self.name = name
        self.sets = sets
    }
    
    convenience init(exerciseData: ExerciseData) {
        let mappedData = ExerciseDataMapper.map(exerciseData: exerciseData)
        self.init(name: mappedData.name, sets: mappedData.sets)

    }
    
    /* MARK: My approach to the convenience init fix I was asked about
    convenience init(exerciseData: ExerciseData) {
        self.init(name: ExerciseType(rawValue: exerciseData.name) ?? .squat,
                  sets: exerciseData.sets.map { ExerciseSet(exerciseSetData: $0)}
        )
    }
    */
    
    enum ExerciseType: String, CaseIterable, Codable {
        case squat = "Squat"
        case legPress = "Leg Press"
        case legCurl = "Leg Curl"
        case legExtension = "Leg Extension"
        case benchPress = "Bench Press"
        case bicepCurl = "Bicep Curl"
        case tricepsExtension = "Triceps Extension"
        case romanianDeadlift = "Romanian Deadlift"
        case backExtension = "Back Extension"
    }
}

class ExerciseSetDataMapper {
    static func map(exerciseSetData: ExerciseSetData) -> (weight: Int, reps: Int, setNumber: Int) {
        let weight = exerciseSetData.weight
        let reps = exerciseSetData.reps
        let setNumber = exerciseSetData.setNumber
        
        return(weight, reps, setNumber)
    }
}

class ExerciseSet : Identifiable, ObservableObject {
    let id = UUID()
    @Published var reps: Int
    @Published var weight: Int
    @Published var setNumber: Int
    @Published var toggleState: Bool = false

    init(reps: Int, weight: Int, setNumber: Int) {
        self.reps = reps
        self.weight = weight
        self.setNumber = setNumber
    }
    
    convenience init(exerciseSetData: ExerciseSetData){
        let mappedData = ExerciseSetDataMapper.map(exerciseSetData: exerciseSetData)
        self.init(reps: mappedData.reps, weight: mappedData.weight, setNumber: mappedData.setNumber)
    }
    
    /* MARK: My approach to the convenience init fix I was asked about
    convenience init(exerciseSetData: ExerciseSetData) {
        self.init(reps: exerciseSetData.reps,
                  weight: exerciseSetData.weight,
                  setNumber: exerciseSetData.setNumber)
    }
     */
}


@Model
class ExerciseData {
    var name: String
    @Relationship var sets: [ExerciseSetData]

    init(name: String, sets: [ExerciseSetData]) {
        self.name = name
        self.sets = sets
    }

    convenience init(exercise: Exercise) {
        self.init(name: exercise.name.rawValue,
                  sets: exercise.sets.map { ExerciseSetData(exerciseSet: $0)}
        )
    }
}


@Model
class ExerciseSetData {
    var reps: Int
    var weight: Int
    var setNumber: Int

    init(reps: Int, weight: Int, setNumber: Int) {
        self.reps = reps
        self.weight = weight
        self.setNumber = setNumber
    }

    convenience init(exerciseSet: ExerciseSet) {
        self.init(reps: exerciseSet.reps,
                  weight: exerciseSet.weight,
                  setNumber: exerciseSet.setNumber
        )
    }
}



