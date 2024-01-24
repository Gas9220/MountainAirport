//
//  FlightTimeHistory.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct FlightTimeHistory: View {
    var flight: FlightInformation

    var timeFormatter: RelativeDateTimeFormatter {
        let rtf = RelativeDateTimeFormatter()
        rtf.unitsStyle = .full
        rtf.dateTimeStyle = .named
        return rtf
    }

    func relativeDate(_ date: Date) -> String {
        return timeFormatter.localizedString(for: date, relativeTo: Date())
    }

    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack {
                Text("On Time History for \(flight.statusBoardName)")
                    .font(.title2)
                    .padding(.top, 30)
                ScrollView {
                    ForEach(flight.history, id: \.day) { history in
                        HStack {
                            Text("\(history.day) day(s) ago - \(history.flightDelayDescription)")
                                .padding()
                            Spacer()
                        }
                        .background(
                            Color.white.opacity(0.2)
                        )
                    }
                }
            }
        }.foregroundColor(.white)
    }
}

struct FlightTimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        FlightTimeHistory(
            flight: FlightData.generateTestFlight(date: Date())
        )
    }
}