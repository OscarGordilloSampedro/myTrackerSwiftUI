//
//  Untitled.swift
//  myTrackerSwiftUI
//
//  Created by Oscar on 6/12/24.
//

import SwiftUI

struct customHeaderButton : View{
    let title : String
    let buttonAction : () -> Void
    
    var body : some View {
        HStack{
            Text(title)
                .customHeaderStyle()
            Spacer()
            Button(action: buttonAction) {
                HStack{
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.orange)
                        .font(.title3)
                }
            }
        }
    }
}
