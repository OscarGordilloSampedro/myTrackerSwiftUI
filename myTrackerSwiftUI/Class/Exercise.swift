//
//  Exercise.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import Foundation
import SwiftData


class Exercise: Identifiable, ObservableObject {
    @Published var exerciseName: ExerciseType
    @Published var sets: [ExerciseSet]

    init(exerciseName: ExerciseType, sets: [ExerciseSet] = []) {
        self.exerciseName = exerciseName
        self.sets = sets
    }
    init(exerciseData: ExerciseData) {
        self.exerciseName = ExerciseType(rawValue: exerciseData.exerciseName) ?? .squat
        self.sets = exerciseData.sets.map { ExerciseSet(exerciseSetData: $0) }
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

    init(from exerciseSet: ExerciseSet) {
        self.reps = exerciseSet.reps
        self.weight = exerciseSet.weight
        self.setNumber = exerciseSet.setNumber
    }
}



