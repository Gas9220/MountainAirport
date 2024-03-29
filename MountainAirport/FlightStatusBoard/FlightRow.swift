//
//  FlightRow.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightRow: View {
    var flight: FlightInformation

    var timeFormatter: DateFormatter {
        let tdf = DateFormatter()
        tdf.timeStyle = .short
        tdf.dateStyle = .none
        return tdf
    }

    var relativeTimeFormatter: RelativeDateTimeFormatter {
        let rdf = RelativeDateTimeFormatter()
        rdf.unitsStyle = .abbreviated
        return rdf
    }

    var body: some View {
        HStack {
            FlightStatusIcon(flight: flight)
                .padding(5)
                .clipShape(RoundedRectangle(cornerRadius: 7))
            VStack(alignment: .leading) {
                Text(flight.flightName)
                    .font(.title2)
                HStack {
                    Text(flight.flightStatus)
                    Text(flight.localTime, formatter: timeFormatter)
                    Text("(") +
                    Text(flight.localTime, formatter: relativeTimeFormatter) +
                    Text(")")
                }
                .foregroundStyle(flight.statusColor)
                HStack {
                    Text(flight.otherAirport)
                    Text("·")
                    Text("Gate \(flight.gate)")
                }.foregroundColor(.gray)
            }
        }
    }
}

struct FlightRow_Previews: PreviewProvider {
    static var previews: some View {
        FlightRow(
            flight: FlightData.generateTestFlight(date: Date())
        )
    }
}
