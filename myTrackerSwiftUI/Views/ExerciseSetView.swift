//
//  ExerciseSetView.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 14/12/24.
//
import SwiftData
import SwiftUI

struct ExerciseSetView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var exerciseSet : ExerciseSet
    var body: some View {
        GridRow{
            Text("\(exerciseSet.setNumber)")
                .padding(8)
                .background(Color.black)
                .cornerRadius(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            
            TextField("0", value: $exerciseSet.reps, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .frame(width: 50)
                .keyboardType(.decimalPad)
                .onChange(of: exerciseSet.reps) {
                    try? modelContext.save()
                    }
            
            TextField("0", value: $exerciseSet.weight, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .frame(width: 50)
                .keyboardType(.decimalPad)
                .onChange(of: exerciseSet.weight) {
                    try? modelContext.save()
                    }
            Button(action:{
                try? modelContext.save()
                exerciseSet.toggleState.toggle() }) {
                Image(systemName: exerciseSet.toggleState ? "arrow.counterclockwise.circle" : "checkmark.circle")
                    .bold()
                    .foregroundStyle(exerciseSet.toggleState ? .orange : .green)
            }
            .buttonStyle(.plain)
            .preferredColorScheme(.dark)
        }
        .foregroundStyle(exerciseSet.toggleState ? .green : .white)
    }
}

#Preview {
    @Previewable @StateObject var exerciseSet = ExerciseSet(reps: 10, weight: 10, setNumber: 1)
    ExerciseSetView(exerciseSet: exerciseSet)
}
