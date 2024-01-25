//
//  FlightTimelineView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 25/01/24.
//

import SwiftUI

struct FlightTimelineView: View {
    var flights: [FlightInformation]

    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            GenericTimeline(events: flights, timeProperty: \.localTime) { flight in
                FlightCardView(flight: flight)
            }
            .padding()
        }
        .foregroundColor(.white)
        .navigationTitle("Flight Timeline")
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlightTimelineView(
                flights: FlightData.generateTestFlights(
                    date: Date()
                )
                .filter {
                    Calendar.current.isDate(
                        $0.localTime,
                        inSameDayAs: Date()
                    )
                }
            )
        }
    }
}
