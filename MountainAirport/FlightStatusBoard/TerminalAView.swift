//
//  TerminalAView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct TerminalAView: View {
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
                Text("Terminal A")
                    .font(.title)
                    .padding()
                Text("Terminal A offers the follow dining options:")
                    .font(.title2)
                Text("\u{2022} Juniper Fiddler")
                Text("\u{2022} Orange Emperor")
                Text("\u{2022}  Aqua Sunset")
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

struct TerminalAView_Previews: PreviewProvider {
    static var previews: some View {
        TerminalAView()
    }
}
