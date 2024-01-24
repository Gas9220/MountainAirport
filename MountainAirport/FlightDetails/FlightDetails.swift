//
//  FlightDetails.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightDetails: View {
    var flight: FlightInformation
    @EnvironmentObject var lastFlightInfo: AppEnvironment
    
    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .leading) {
                FlightDetailHeader(flight: flight)
                FlightInfoPanel(flight: flight)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20.0)
                            .opacity(0.3)
                    )
                Spacer()
            }.foregroundColor(.white)
                .padding()
                .navigationTitle("\(flight.airline) Flight \(flight.number)")
        }.onAppear {
            lastFlightInfo.lastFlightId = flight.id
        }
    }
}


#Preview {
    FlightDetails(flight: FlightData.generateTestFlight(date: Date()))
        .environmentObject(FlightNavigationInfo())
}
