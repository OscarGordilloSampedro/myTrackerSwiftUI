//
//  dayCreationView.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import SwiftUI

struct DayCreationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAlertMessage = false
    @State private var alertMessage = ""

   
    @Binding var days: [Day]
    
    @State private var day = Day(name: "", identifier: UUID(), exercises: [])
    @State private var exerciseTypes: [Exercise] = [
        Exercise(exerciseName: .squat, sets: [
            ExerciseSet(reps: 0, weight: 0, setNumber: 1)
        ])
]
    @State private var newExerciseType = Exercise.ExerciseType.squat
    var body: some View {
        NavigationStack(){
            Form{
                Section(header: Text("Day information").customHeaderStyle()){
                    TextField("Day Name", text: $day.name)
                        .bold()
                }
                Section(header: HStack{
                    Text("Exercise").customHeaderStyle()
                    Spacer()
                    Button(action: {addExercise()}) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                }){
                    ForEach($exerciseTypes) { $exercise in
                        HStack{
                            Picker("Chose your exercise", selection: $exercise.exerciseName) {
                                ForEach(Exercise.ExerciseType.allCases, id: \.self) { exerciseType in
                                    Text(exerciseType.rawValue)
                                        .tag(exerciseType.rawValue)
                                    
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            //Remove Picker
                            Button(action: {removeExercise(exercise)}) {Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .preferredColorScheme(.dark)
                .navigationTitle("New Workout")
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if day.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            showingAlertMessage = true
                            alertMessage = "Please enter a name for this day"
                        } else {
                            appendDay()
                            dismiss()
                        }
                    }
                }
                
            }
        
        }
        .alert("Warning", isPresented: $showingAlertMessage){
            Button("Ok"){}
        }message: {
            Text(alertMessage)
        }
    }
    func removeExercise(_ exercise : Exercise) {
        if let index = exerciseTypes.firstIndex(where: { $0.id == exercise.id }) {
            exerciseTypes.remove(at: index)}
    }
    func addExercise() {
        exerciseTypes.append(Exercise(exerciseName: newExerciseType, sets: [
            ExerciseSet(reps: 0, weight: 0, setNumber: 1)
        ]))
    }
    func appendDay() {
        let newDay = Day(name: day.name, identifier: UUID(), exercises: exerciseTypes)
        days.append(newDay)
        modelContext.insert(DayData(day: newDay))
    }
}


#Preview {
    DayCreationView(days: .constant([]))
}
