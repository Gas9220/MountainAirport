//
//  TerminalMapView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct TerminalMapView: View {
    var flight: FlightInformation

    var body: some View {
        Group {
            if flight.terminal == "A" {
                Image("terminal-a-map")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
            } else {
                Image("terminal-b-map")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .overlay {
            TerminalStoresView(flight: flight)
            GatePathView(flight: flight)
                .foregroundStyle(.white)
        }
    }
}

struct TerminalMapView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TerminalMapView(
                flight: FlightData().flights.first { $0.terminal == "A" }!
            )
            TerminalMapView(
                flight: FlightData().flights.first { $0.terminal == "B" }!
            )
        }
    }
}
