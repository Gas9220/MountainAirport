//
//  FlightStatusBoard.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightStatusBoard: View {
    var flights: [FlightInformation]

    var body: some View {
        NavigationStack {
            List(flights, id: \.id) { flight in
                NavigationLink(flight.statusBoardName, value: flight)
            }
            .navigationDestination(for: FlightInformation.self) { flight in
                FlightDetails(flight: flight)
            }
        .navigationTitle("Today's Flight Status")
        }
     }
}

#Preview {
    FlightStatusBoard(flights: FlightData.generateTestFlights(date: Date()))
}
