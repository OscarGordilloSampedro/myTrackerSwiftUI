//
//  ExerciseView.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 14/12/24.
//

import SwiftUI
import SwiftData

struct ExerciseView: View {
    @ObservedObject  var exercise : Exercise
    @Environment(\.modelContext) var modelContext
    var body: some View {
        Grid{
            GridRow{
                Text("Set")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                
                Text("Reps")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .bold()
                
                Text("Kg")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .bold()
            }
            
            Divider()
            
            ForEach($exercise.sets, id: \.id) { $exerciseSet in
                ExerciseSetView(exerciseSet: exerciseSet)
                
            }
        }
        .onAppear{
            try? modelContext.save()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    @Previewable @StateObject var exercise = Exercise(exerciseName: .backExtension, sets: [
            ExerciseSet(reps: 10, weight: 15, setNumber: 1)
        ])
    ExerciseView(exercise: exercise)
}
