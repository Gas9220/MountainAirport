//
//  HighlightActionView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct HighlightActionView: View {
    var flightId: Int
    @Binding var highlightedIds: [Int]

    var body: some View {
        Button {
            toggleHighLight()
        } label: {
            Image(systemName: "highlighter")
        }
        .tint(.yellow)
    }

    func toggleHighLight() {
        let flightIdx = highlightedIds.firstIndex { $0 == flightId }

        if let index = flightIdx {
            highlightedIds.remove(at: index)
        } else {
            highlightedIds.append(flightId)
        }
    }
}

#Preview {
    HighlightActionView(flightId: 1, highlightedIds: .constant([1]))
}
