//
//  FlightStatusBoard.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightStatusBoard: View {
    @State private var hidePast = false
    @State private var path: [FlightInformation] = []

    var flights: [FlightInformation]

    var shownFlights: [FlightInformation] {
        hidePast ? flights.filter { $0.localTime >= Date() } : flights
    }

    var flightToShow: FlightInformation?

    var body: some View {
        NavigationStack(path: $path) {
            List(shownFlights, id: \.id) { flight in
                NavigationLink(flight.statusBoardName, value: flight)
            }
            .navigationDestination(for: FlightInformation.self) { flight in
                FlightDetails(flight: flight)
            }
            .navigationTitle("Today's Flight Status")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle("Hide Past", isOn: $hidePast)
                        .toggleStyle(.switch)
                }
            }
        }
        .onAppear {
            if let flight = flightToShow {
                path.append(flight)
            }
        }
    }
}

#Preview {
    FlightStatusBoard(flights: FlightData.generateTestFlights(date: Date()))
        .environmentObject(FlightNavigationInfo())
}
