//
//  Exercise.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import Foundation
class Exercise: Identifiable {
    var exerciseName : ExerciseType
    var reps: Int = 0
    var weight : Int = 0
    
    init(exerciseName: ExerciseType,reps: Int, weight: Int) {
        self.exerciseName = exerciseName
        self.reps = max(0,reps)
        self.weight = max(0,weight)
    }
    
    enum ExerciseType: String, CaseIterable{
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
    let allExerciseTypes = ExerciseType.allCases.map {$0.rawValue}
    
}

