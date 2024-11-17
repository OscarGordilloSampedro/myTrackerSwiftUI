//
//  dayCreationView.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import SwiftUI

struct DayCreationView: View {
    @Environment(\.dismiss) private var dismiss
   
    @Binding var days: [Day]
    
    @State private var day = Day(name: "", identifier: UUID(), exercises: [])
    @State private var exerciseTypes : [Exercise] = [Exercise(exerciseName: .backExtension, reps: 0, weight: 0)]
    
    @State private var newExerciseType : Exercise.ExerciseType = .backExtension //Default value for new Pickers
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
                    Button(action: {
                        exerciseTypes.append(Exercise(exerciseName: newExerciseType, reps: 0, weight: 0))
                        
                    }) { Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                }){
                    ForEach($exerciseTypes) { $exercise in
                        HStack{
                            Picker("Chose your exercise", selection: $exercise.exerciseName) {
                                ForEach(Exercise.ExerciseType.allCases, id: \.self) { exerciseType in
                                    Text(exerciseType.rawValue)
                                        .tag(exerciseType)
                                    
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            //Remove Picker
                            Button(action: {if let index = exerciseTypes.firstIndex(where: { $0.id == exercise.id }) {exerciseTypes.remove(at: index)}
                            }) {Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .preferredColorScheme(.dark)
                .navigationTitle("New Workout")
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        appendDay()
                        dismiss()
                    }
                }
                
            }
        
        }
    }
    func appendDay() {
        let newDay = Day(name: day.name, identifier: UUID(), exercises: exerciseTypes)
        days.append(newDay)
    }
}

//Ask Jorge
#Preview {
    DayCreationView(days: .constant([]))
}
