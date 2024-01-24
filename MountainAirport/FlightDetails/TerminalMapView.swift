//
//  TerminalMapView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct TerminalStoresView: View {
    var flight: FlightInformation

    var stores: [TerminalStore] {
        if flight.terminal == "A" {
            return TerminalStore.terminalStoresA
        } else {
            return TerminalStore.terminalStoresB
        }
    }
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            let storeWidth = width / 6
            let storeHeight = storeWidth / 1.75
            let storeSpacing = width / 5
            let firstStoreOffset = flight.terminal == "A" ? width - storeSpacing : storeSpacing - storeWidth
            let direction = flight.terminal == "A" ? -1.0 : 1.0

            ForEach(stores.indices, id: \.self) { index in
                let store = stores[index]
                let xOffset = Double(index) * storeSpacing * direction + firstStoreOffset

                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(
                        Color(
                            hue: 0.3333,
                            saturation: 1.0 - store.howBusy,
                            brightness: 1.0 - store.howBusy
                        )
                    )
                    .overlay(
                        Text(store.shortName)
                            .font(.footnote)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    )
                    .frame(width: storeWidth, height: storeHeight)
                    .offset(x: xOffset, y: height * 0.4)
            }
        }
    }
}

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
