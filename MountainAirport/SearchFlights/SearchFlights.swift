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

                List(matchingFlights) { flight in
                    SearchResultRow(flight: flight)
                }

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
