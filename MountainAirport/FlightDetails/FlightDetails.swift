//
//  FlightDetails.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightDetails: View {
    var flight: FlightInformation
    
    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .leading) {
                HStack {
                    FlightDirectionGraphic(direction: flight.direction)
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        Text("\(flight.dirString) \(flight.otherAirport)")
                        Text(flight.flightStatus)
                            .font(.subheadline)
                    }.font(.title2)
                }
                Spacer()
            }.foregroundColor(.white)
                .padding()
                .navigationTitle("\(flight.airline) Flight \(flight.number)")
        }
    }
}

struct FlightDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlightDetails(
                flight: FlightData.generateTestFlight(date: Date())
            )
        }
    }
}