//
//  FlightCardView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 25/01/24.
//

import SwiftUI

struct FlightCardView: View {
    var flight: FlightInformation

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(flight.statusBoardName)
                Spacer()
            }

            HStack(alignment: .bottom) {
                DepartureTimeView(flight: flight)
                Spacer()
                ArrivalTimeView(flight: flight)
            }
        }
    }
}

struct FlightCardView_Previews: PreviewProvider {
    static var previews: some View {
        FlightCardView(
            flight: FlightData.generateTestFlight(date: Date())
        )
    }
}

struct DepartureTimeView: View {
    var flight: FlightInformation

    var body: some View {
        VStack {
            if flight.direction == .arrival {
                Text(flight.otherAirport)
            }
            Text(shortTimeFormatter.string(
                    from: flight.departureTime)
            )
        }
    }
}

struct ArrivalTimeView: View {
    var flight: FlightInformation

    var body: some View {
        VStack {
            if flight.direction == .departure {
                Text(flight.otherAirport)
            }
            Text(shortTimeFormatter.string(
                    from: flight.arrivalTime
                )
            )
        }
    }
}
