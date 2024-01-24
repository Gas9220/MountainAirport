//
//  SearchResultRow.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct SearchResultRow: View {
    var flight: FlightInformation
    @State private var isPresented = false

    var timeFormatter: DateFormatter {
        let tdf = DateFormatter()
        tdf.timeStyle = .short
        tdf.dateStyle = .medium
        return tdf
    }

    var body: some View {
        Button(
            action: {
                isPresented.toggle()
            }, label: {
                FlightSearchSummary(flight: flight)
            })
        .sheet(
            isPresented: $isPresented,
            onDismiss: {
                print("Modal dismissed. State now: \(isPresented)")
            },
            content: {
                FlightSearchDetails(flight: flight)
            }
        )
    }
}

struct SearchResultRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultRow(
            flight: FlightData.generateTestFlight(date: Date())
        )
    }
}
