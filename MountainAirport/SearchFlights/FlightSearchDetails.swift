//
//  FlightSearchDetails.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct FlightSearchDetails: View {
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
        }.onAppear {
            lastFlightInfo.lastFlightId = flight.id
        }
    }
}

struct FlightSearchDetails_Previews: PreviewProvider {
    static var previews: some View {
        FlightSearchDetails(
            flight: FlightData.generateTestFlight(date: Date())
        ).environmentObject(AppEnvironment())
    }
}
