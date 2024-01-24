//
//  TerminalBView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct TerminalBView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .rotationEffect(.degrees(180.0))
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .leading) {
                Text("Terminal B")
                    .font(.title)
                    .padding()
                Text("Terminal B offers the follow dining options:")
                    .font(.title2)
                Text("\u{2022} The Olive Morning")
                Text("\u{2022} The Ruby Afternoon")
                Text("\u{2022} Sunset Elements")
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .font(.title3)
        }
        .onTapGesture {
            dismiss()
        }
    }
}

struct TerminalBView_Previews: PreviewProvider {
    static var previews: some View {
        TerminalBView()
    }
}
