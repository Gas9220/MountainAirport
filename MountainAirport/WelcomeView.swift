//
//  WelcomeView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

enum FlightViewId: CaseIterable {
    case showFlightStatus
}

struct ViewButton: Identifiable {
    var id: FlightViewId
    var title: String
    var subtitle: String
}

struct WelcomeView: View {
    @StateObject var flightInfo = FlightData()

    @State private var selectedView: FlightViewId?

    var sidebarButtons: [ViewButton] {
        var buttons: [ViewButton] = []

        buttons.append(
            ViewButton(id: .showFlightStatus,
                       title: "Flight Status",
                       subtitle: "Departure and arrival information")
        )

        return buttons
    }

    var body: some View {
        NavigationSplitView {
            List(sidebarButtons, selection: $selectedView) { button in
                VStack {
                    Text(button.title)
                    Text(button.subtitle)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Mountain Airport")
        } detail: {
            Text("Detail")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
