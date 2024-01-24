//
//  FlightSearchDetails.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct FlightSearchDetails: View {
    @Binding var showModal: Bool

    var flight: FlightInformation
    @EnvironmentObject var lastFlightInfo: AppEnvironment

    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .leading) {
                HStack {
                    FlightDetailHeader(flight: flight)
                    Spacer()
                    Button("Close") {
                        showModal = false
                    }
                }
                FlightInfoPanel(flight: flight)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20.0)
                            .opacity(0.3)
                    )
                Spacer()
            }.foregroundColor(.white)
                .padding()
        }
        .interactiveDismissDisabled()
        .onAppear {
            lastFlightInfo.lastFlightId = flight.id
        }
    }
}

struct FlightSearchDetails_Previews: PreviewProvider {
    static var previews: some View {
        FlightSearchDetails(
            showModal: .constant(true), flight: FlightData.generateTestFlight(date: Date())
        ).environmentObject(AppEnvironment())
    }
}
