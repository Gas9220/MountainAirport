//
//  GenericTimeline.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 25/01/24.
//

import SwiftUI

struct GenericTimeline<Content, T>: View where Content: View {
    var events: [T]
    let content: (T) -> Content

    init(events: [T],@ViewBuilder content: @escaping (T) -> Content) {
        self.events = events
        self.content = content
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(events.indices, id: \.self) { index in
                    content(events[index])
                }
            }
        }
    }
}

#Preview {
    GenericTimeline(events: FlightData.generateTestFlights(date: Date())) { flight in
        FlightCardView(flight: flight)
    }
}
