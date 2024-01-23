//
//  FlightStatusBoard.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightList: View {
    var flights: [FlightInformation]
    var flightToShow: FlightInformation?
    @State private var path: [FlightInformation] = []

    var body: some View {
        NavigationStack(path: $path) {
            List(flights, id: \.id) { flight in
                NavigationLink(flight.statusBoardName, value: flight)
            }
            .navigationDestination(
                for: FlightInformation.self,
                destination: { flight in
                    FlightDetails(flight: flight)
                }
            )
        }
        .onAppear {
            if let flight = flightToShow {
                path.append(flight)
            }
        }
    }
}

struct FlightStatusBoard: View {
    @State private var hidePast = false

    var flights: [FlightInformation]

    var shownFlights: [FlightInformation] {
        hidePast ? flights.filter { $0.localTime >= Date() } : flights
    }

    var flightToShow: FlightInformation?

    var body: some View {
        TabView {
            FlightList(
                flights: shownFlights.filter { $0.direction == .arrival }
            )
            .tabItem {
                Image("descending-airplane")
                    .resizable()
                Text("Arrivals")
            }
            FlightList(
                flights: shownFlights,
                flightToShow: flightToShow
            )
            .tabItem {
                Image(systemName: "airplane")
                    .resizable()
                Text("All")
            }
            FlightList(
                flights: shownFlights.filter { $0.direction == .departure }
            )
            .tabItem {
                Image("ascending-airplane")
                Text("Departures")
            }
        }
        .navigationTitle("Today's Flight Status")
        .navigationBarItems(
            trailing: Toggle("Hide Past", isOn: $hidePast)
        )
    }
}

    #Preview {
        FlightStatusBoard(flights: FlightData.generateTestFlights(date: Date()))
            .environmentObject(FlightNavigationInfo())
    }
