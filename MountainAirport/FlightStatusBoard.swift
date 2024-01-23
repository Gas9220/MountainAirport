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
    @AppStorage("FlightStatusCurrentTab") var selectedTab = 1
    @State private var hidePast = false

    var flights: [FlightInformation]

    var shownFlights: [FlightInformation] {
        hidePast ? flights.filter { $0.localTime >= Date() } : flights
    }

    var shortDateString: String {
      let dateF = DateFormatter()
      dateF.timeStyle = .none
      dateF.dateFormat = "MMM d"
      return dateF.string(from: Date())
    }

    var flightToShow: FlightInformation?

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
            .badge(shownFlights.filter { $0.direction == .arrival }.count)
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
            .badge(shortDateString)
            .tag(1)

            FlightList(
                flights: shownFlights.filter { $0.direction == .departure }
            )
            .tabItem {
                Image("ascending-airplane")
                Text("Departures")
            }
            .badge(shownFlights.filter { $0.direction == .departure }.count)
            .tag(2)
        }
        .navigationTitle("Today's Flight Status")
        .navigationBarItems(
            trailing: Toggle("Hide Past", isOn: $hidePast)
        )
        .onAppear {
            if flightToShow != nil {
                selectedTab = 1
            }
        }
    }
}

    #Preview {
        FlightStatusBoard(flights: FlightData.generateTestFlights(date: Date()))
            .environmentObject(FlightNavigationInfo())
    }
