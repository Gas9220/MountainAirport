//
//  FlightList.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightList: View {
    @Binding var highlightedIds: [Int]
    var flights: [FlightInformation]
    var flightToShow: FlightInformation?
    @State private var path: [FlightInformation] = []

    var nextFlightId: Int {
        guard let flight = flights.first( where: { $0.localTime >= Date() } ) else {
            return flights.last?.id ?? 0
        }
        return flight.id
    }

    func rowHighLighted(_ flightId: Int) -> Bool {
        return highlightedIds.contains { $0 == flightId }
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollViewReader { scrollProxy in
                List(flights) { flight in
                    NavigationLink(value: flight) {
                        FlightRow(flight: flight)
                    }
                    .listRowBackground(
                        rowHighLighted(flight.id) ? Color.yellow.opacity(0.5) : Color.clear
                    )
                    .swipeActions(edge: .leading) {
                        HighlightActionView(flightId: flight.id, highlightedIds: $highlightedIds)
                    }
                }
                .onAppear {
                    scrollProxy.scrollTo(nextFlightId)
                }
                .navigationDestination(
                    for: FlightInformation.self,
                    destination: { flight in
                        FlightDetails(flight: flight)
                    })
            }
        }
        .onAppear {
            if let flight = flightToShow {
                path.append(flight)
            }
        }
    }
}

struct FlightList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FlightList(
                highlightedIds: .constant([15]), flights: FlightData.generateTestFlights(date: Date())
            )
        }
        .environmentObject(FlightNavigationInfo())
    }
}
