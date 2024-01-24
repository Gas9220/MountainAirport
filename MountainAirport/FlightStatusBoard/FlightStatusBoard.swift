//
//  FlightStatusBoard.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightStatusBoard: View {
    @State var flights: [FlightInformation]
    var flightToShow: FlightInformation?
    @State private var hidePast = false
    @AppStorage("FlightStatusCurrentTab") var selectedTab = 1
    @State var highlightedIds: [Int] = []

    var shownFlights: [FlightInformation] {
        hidePast ?
        flights.filter { $0.localTime >= Date() } :
        flights
    }

    func lastUpdateString(_ date: Date) -> String {
        let dateF = DateFormatter()
        dateF.timeStyle = .short
        dateF.dateFormat = .none
        return "Last updated: \(dateF.string(from: Date()))"
    }

    var body: some View {
        TimelineView(.animation) { context in
            VStack {
                Text(lastUpdateString(context.date))
                    .font(.footnote)
                TabView(selection: $selectedTab) {
                    FlightList(
                        flights: shownFlights.filter { $0.direction == .arrival }, highlightedIds: $highlightedIds
                    ).tabItem {
                        Image("descending-airplane")
                            .resizable()
                        Text("Arrivals")
                    }
                    .badge(shownFlights.filter { $0.direction == .arrival }.count)
                    .tag(0)
                    FlightList(
                        flights: shownFlights,
                        flightToShow: flightToShow,
                        highlightedIds: $highlightedIds
                    ).tabItem {
                        Image(systemName: "airplane")
                            .resizable()
                        Text("All")
                    }
                    .tag(1)
                    FlightList(
                        flights: shownFlights.filter { $0.direction == .departure },
                        highlightedIds: $highlightedIds
                    ).tabItem {
                        Image("ascending-airplane")
                        Text("Departures")
                    }
                    .badge(shownFlights.filter { $0.direction == .departure }.count)
                    .tag(2)
                }
                .onAppear {
                    if flightToShow != nil {
                        selectedTab = 1
                    }
                }
                .refreshable {
                    await flights = FlightData.refreshFlights()
                }
                .navigationTitle("Flight Status")
                .navigationBarItems(
                    trailing: Toggle(
                        "Hide Past",
                        isOn: $hidePast
                    )
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        FlightStatusBoard(flights: FlightData.generateTestFlights(date: Date()))
    }
}
