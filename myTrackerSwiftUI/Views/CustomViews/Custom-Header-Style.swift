//
//  headerTitles.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 7/11/24.
//

import SwiftUI

struct CustomHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundStyle(.orange)
            .bold()
    }
}

extension View {
    func customHeaderStyle() -> some View {
        self.modifier(CustomHeader())
    }
}
