//
//  Exercise.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import Foundation
import SwiftData


class Exercise: Identifiable, ObservableObject {
    /// #Suggestion
    /// It is more intuitive to name this property just **name**, so when you use it, for example, having a property declared as `let exersice = Exercise()`,  you will do it like: `exercise.name` not `exercise.exerciseName`
    @Published var exerciseName: ExerciseType
    @Published var sets: [ExerciseSet]

    init(exerciseName: ExerciseType, sets: [ExerciseSet] = []) {
        self.exerciseName = exerciseName
        self.sets = sets
    }
    
    convenience init(exerciseData: ExerciseData) {
        /// #Suggestion
        /// If you have this two init, why not to use the one above inside this one and convert this init in a convinience init? (Actually I think this work is better to make it in a class that has the respnsibility to map the data to return the Exercise instance without having two inits that practically makes the same work).
        /// This is your code:
        /// `self.exerciseName = ExerciseType(rawValue: exerciseData.exerciseName) ?? .squat`
        /// `self.sets = exerciseData.sets.map { ExerciseSet(exerciseSetData: $0) }`
        /// This is what I would do:
        self.init(
            exerciseName: ExerciseType(rawValue: exerciseData.exerciseName) ?? .squat,
            sets: exerciseData.sets.map { ExerciseSet(exerciseSetData: $0) }
        )
        
    }

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
    
    /// #Suggestion
    /// Same suggestion that I did above, try to implement it yourself here. Notice you have to make it a **convinience init** to do so.
    init(exerciseSetData: ExerciseSetData) {
        self.reps = exerciseSetData.reps
        self.weight = exerciseSetData.weight
        self.setNumber = exerciseSetData.setNumber
    }
    
}


@Model
class ExerciseData {
    var exerciseName: String
    @Relationship var sets: [ExerciseSetData]

    init(exerciseName: String, sets: [ExerciseSetData]) {
        self.exerciseName = exerciseName
        self.sets = sets
    }

    /// #Suggestion
    /// Same suggestion that I did above, try to implement it yourself here. Notice you have to make it a **convinience init** to do so.
    init(exercise: Exercise) {
        self.exerciseName = exercise.exerciseName.rawValue
        self.sets = exercise.sets.map { ExerciseSetData(from: $0) }
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

    /// #Suggestion
    /// Two things here, if you are following the convention to not use the **from** prefix in the init definition try to follow your convention and not use it here in the init, try to have consistency.
    /// The other thing is the same as I marked aboved, try to implement it yourself here. Notice you have to make it a **convinience init** to do so.
    init(from exerciseSet: ExerciseSet) {
        self.reps = exerciseSet.reps
        self.weight = exerciseSet.weight
        self.setNumber = exerciseSet.setNumber
    }
}



