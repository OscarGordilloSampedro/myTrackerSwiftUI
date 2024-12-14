//
//  DayView.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 12/11/24.
//

import SwiftUI

struct DayView: View {
    
    @Binding var days: [Day]
    @ObservedObject var day: Day
    
    var body: some View {
        NavigationStack{
            Form{
                if day.exercises.isEmpty {
                    Text("No exercises added yet.")
                        .foregroundStyle(.gray)
                }else {
                    ForEach ($day.exercises, id: \.id) { $exercise in
                        VStack(alignment: .leading, spacing: 5) {
                            customHeaderButton(title: exercise.exerciseName.rawValue, buttonAction: {
                                addNewSeries(exercise: exercise)
                            })
                            .buttonStyle(.plain)
                            ExerciseView(exercise: exercise )
                            }
                            .padding(.vertical, 4)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text(day.name)
                        .foregroundStyle(Color(.orange))
                        .font(.title)
                        .bold()
                }
            }
        }
    }
    func addNewSeries(exercise : Exercise) {
        let newSet = ExerciseSet(reps: 0, weight: 0, setNumber: exercise.sets.count + 1)
        exercise.sets.append(newSet)
        //Check why not updating until view loads again
     }
    
}



#Preview {
    let sampleExercises = [
        Exercise(exerciseName: Exercise.ExerciseType.backExtension, sets: [
            ExerciseSet(reps: 10, weight: 15, setNumber: 1)
        ]),
        Exercise(exerciseName: Exercise.ExerciseType.legCurl, sets: [
            ExerciseSet(reps: 10, weight: 15, setNumber: 1)
        ]),
        Exercise(exerciseName: Exercise.ExerciseType.bicepCurl, sets: [
            ExerciseSet(reps: 10, weight: 15, setNumber: 1)
        ]),
        Exercise(exerciseName: Exercise.ExerciseType.romanianDeadlift, sets: [
            ExerciseSet(reps: 10, weight: 15, setNumber: 1)
        ]),
        Exercise(exerciseName: Exercise.ExerciseType.benchPress, sets: [
            ExerciseSet(reps: 10, weight: 15, setNumber: 1)
        ]),
        Exercise(exerciseName: Exercise.ExerciseType.tricepsExtension, sets: [
            ExerciseSet(reps: 10, weight: 15, setNumber: 1)
        ]),
        Exercise(exerciseName: Exercise.ExerciseType.legCurl, sets: [
            ExerciseSet(reps: 10, weight: 15, setNumber: 1)
        ])
    ]
    let sampleDay = Day(name: "Testing day", identifier: UUID(), exercises: sampleExercises)
    
    DayView(
        days: .constant([]),
        day: sampleDay
    )
}
