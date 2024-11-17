//
//  ContentView.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var days: [Day] = []
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(days) { day in
                        NavigationLink(destination: DayView(days: $days)) {
                            Text("\(day.name)")
                                .customHeaderStyle()
                                .padding(.bottom)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("myTracker")
            .toolbar {
                NavigationLink(destination: DayCreationView(days: $days)) {
                    Label("Create new routine", systemImage: "")
                        .bold()
                        .foregroundStyle(.orange)
                }
            }
            .preferredColorScheme(.dark)
        }
          
        }
    }
#Preview {
    ContentView()
}
