//
//  WelcomeView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

enum FlightViewId: CaseIterable {
    case showFlightStatus
    case searchFlights
    case showLastFlight
}

struct ViewButton: Identifiable {
    var id: FlightViewId
    var title: String
    var subtitle: String
}

struct WelcomeView: View {
    @StateObject var flightInfo = FlightData()
    @State private var selectedView: FlightViewId?
    @StateObject var lastFlightInfo = FlightNavigationInfo()

    var sidebarButtons: [ViewButton] {
        var buttons: [ViewButton] = []

        buttons.append(
            ViewButton(
                id: .showFlightStatus,
                title: "Flight Status",
                subtitle: "Departure and arrival information"
            )
        )

        buttons.append(
            ViewButton(
                id: .searchFlights,
                title: "Search Flights",
                subtitle: "Search Upcoming Flights"
            )
        )

        if let flightId = lastFlightInfo.lastFlightId,
           let flight = flightInfo.getFlightById(flightId) {
            buttons.append(
                ViewButton(
                    id: .showLastFlight,
                    title: "\(flight.flightName)",
                    subtitle: "The Last Flight You Viewed"
                )
            )
        }
        return buttons
    }

    var body: some View {
        NavigationSplitView {
            List(sidebarButtons, selection: $selectedView) { button in
                WelcomeButtonView(
                    title: button.title,
                    subTitle: button.subtitle
                )
            }
            .navigationTitle("Mountain Airport")
            .listStyle(.plain)
        } detail: {
            if let view = selectedView {
                switch view {
                case .showFlightStatus:
                    FlightStatusBoard(flights: flightInfo.getDaysFlights(Date()))
                case .searchFlights:
                    SearchFlights(flightData: flightInfo.flights)
                case .showLastFlight:
                    if let flightId = lastFlightInfo.lastFlightId,
                       let flight = flightInfo.getFlightById(flightId) {
                        FlightStatusBoard(
                            flights: flightInfo.getDaysFlights(Date()),
                            flightToShow: flight
                        )
                    }
                }
            } else {
                Text("Select an option in the sidebar.")
            }
        }
        .environmentObject(lastFlightInfo)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
