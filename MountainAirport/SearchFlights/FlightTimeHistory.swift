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
                .ignoresSafeArea()
            VStack {
                Text("On Time History for \(flight.statusBoardName)")
                    .font(.title2)
                    .padding(.top, 30)
                ScrollView {
                    HistoryChartView(flightHistory: flight.history)
                        .frame(height: 600)
                    HistoryPieChart(flightHistory: flight.history)
                        .font(.footnote)
                        .frame(width: 250, height: 250)
                        .padding(5)
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct FlightTimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        FlightTimeHistory(
            flight: FlightData.generateTestFlight(date: Date())
        )
    }
}
