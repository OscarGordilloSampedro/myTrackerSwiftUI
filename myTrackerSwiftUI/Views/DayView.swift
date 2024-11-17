//
//  DayView.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 12/11/24.
//

import SwiftUI

struct DayView: View {
    @Binding var days: [Day]
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    Text("Placeholder")
                }
            }
        }
        .navigationTitle("Your Workout")
        .preferredColorScheme(.dark)
        }
    }


//Ask Jorge
#Preview {
    DayView(days: .constant([]))
}
