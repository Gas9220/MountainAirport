//
//  SearchFlights.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct SearchFlights: View {
    var flightData: [FlightInformation]
    @State private var date = Date()
    @State private var directionFilter: FlightDirection = .none
    @State private var city = ""

    var matchingFlights: [FlightInformation] {
        var matchingFlights = flightData

        if directionFilter != .none {
            matchingFlights = matchingFlights.filter {
                $0.direction == directionFilter
            }
        }

        if !city.isEmpty {
            matchingFlights = matchingFlights.filter {
                $0.otherAirport.lowercased().contains(city.lowercased())
            }
        }

        return matchingFlights
    }

    var flightDates: [Date] {
        let allDates = matchingFlights.map { $0.localTime.dateOnly }
        let uniqueDates = Array(Set(allDates))
        return uniqueDates.sorted()
    }

    func flightsForDay(date: Date) -> [FlightInformation] {
        matchingFlights.filter {
            Calendar.current.isDate($0.localTime, inSameDayAs: date)
        }
    }
    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Picker(
                    selection: $directionFilter,
                    label: Text("Flight Direction")
                ) {
                    Text("All").tag(FlightDirection.none)
                    Text("Arrivals").tag(FlightDirection.arrival)
                    Text("Departures").tag(FlightDirection.departure)
                }
                .background(Color.white)
                .pickerStyle(SegmentedPickerStyle())

                List {
                    ForEach(flightDates, id: \.hashValue) { date in
                        Section {
                            ForEach(flightsForDay(date: date)) { flight in
                                SearchResultRow(flight: flight)
                            }
                        } header: {
                            Text(longDateFormatter.string(from: date))
                        } footer: {
                            Text("Matching flights " + "\(flightsForDay(date: date).count)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())

                Spacer()
            }
            .searchable(text: $city)
            .navigationBarTitle("Search Flights")
            .padding()
        }
    }
}

struct SearchFlights_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchFlights(flightData: FlightData.generateTestFlights(date: Date())
            )
        }
    }
}
