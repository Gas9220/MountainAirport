//
//  FlightList.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightList: View {
    var flights: [FlightInformation]
    var flightToShow: FlightInformation?
    @State private var path: [FlightInformation] = []

    var nextFlightId: Int {
        guard let flight = flights.first( where: { $0.localTime >= Date() } ) else {
            return flights.last?.id ?? 0
        }
        return flight.id
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollViewReader { scrollProxy in
                List(flights) { flight in
                    NavigationLink(value: flight) {
                        FlightRow(flight: flight)
                    }
                }
                .onAppear {
                    scrollProxy.scrollTo(nextFlightId, anchor: .center)
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
                flights: FlightData.generateTestFlights(date: Date())
            )
        }
        .environmentObject(FlightNavigationInfo())
    }
}
