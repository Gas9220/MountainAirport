//
//  FlightStatusBoard.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightStatusBoard: View {
    var flights: [FlightInformation]
    var flightToShow: FlightInformation?
    @State private var hidePast = false
    @AppStorage("FlightStatusCurrentTab") var selectedTab = 1

    var shownFlights: [FlightInformation] {
        hidePast ?
        flights.filter { $0.localTime >= Date() } :
        flights
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            FlightList(
                flights: shownFlights.filter { $0.direction == .arrival }
            )
            .tabItem {
                Image("descending-airplane")
                    .resizable()
                Text("Arrivals")
            }
            .tag(0)
            FlightList(
                flights: shownFlights,
                flightToShow: flightToShow
            )
            .tabItem {
                Image(systemName: "airplane")
                    .resizable()
                Text("All")
            }
            .tag(1)
            FlightList(
                flights: shownFlights.filter { $0.direction == .departure }
            )
            .tabItem {
                Image("ascending-airplane")
                Text("Departures")
            }
            .tag(2)
        }
        .onAppear {
            if flightToShow != nil {
                selectedTab = 1
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