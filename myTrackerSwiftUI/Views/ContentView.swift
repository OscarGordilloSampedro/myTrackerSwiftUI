//
//  ContentView.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var days: [Day] = []
    
    @Query var dayDataList: [DayData]
    var body: some View {
        NavigationStack {
            if dayDataList.isEmpty {
                NavigationLink(destination: DayCreationView(days: $days)) {
                    ContentUnavailableView {
                        Label("Your fitness journey starts here!", systemImage: "dumbbell")
                    }description: {
                        Text("Let’s build your first routine!")
                    }
                    .padding()
                }
            }
            VStack {
                List {
                    ForEach(days) { day in
                        NavigationLink(destination: DayView(days: $days, day: day)) {
                            HStack{
                                Image(systemName: "figure.strengthtraining.traditional")
                            VStack{
                                Text("\(day.name)")
                                    .customHeaderStyle()
                            }
                        }
                           
                        }
                    }
                    .onDelete(perform: deleteDay)
                }
                .padding(.top)
            }
            .navigationTitle("myTracker")
            .toolbar {
                NavigationLink(destination: DayCreationView(days: $days)) {
                    Label("Create new routine", systemImage: "plus.circle.fill")
                        .bold()
                        .foregroundStyle(.orange)
                }
            }
            .preferredColorScheme(.dark)
        }
        
        .onAppear {
            days = dayDataList.map { Day(dayData: $0) }
        }
        }
    func deleteDay(at offsets: IndexSet) {
        withAnimation{
            for offset in offsets {
                let day = days[offset]
                if let dayDataToDelete = dayDataList.first(where: { $0.identifier == day.identifier }) {
                              modelContext.delete(dayDataToDelete)
                }
            }
            days.remove(atOffsets: offsets)
            try? modelContext.save()
        }
    }
}
#Preview {
    ContentView()
}
