//
//  FlightInfoPanel.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

extension AnyTransition {
    static var buttonNameTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale(scale: 0.0)
            .combined(with: .opacity)

        return asymmetric(insertion: insertion, removal: removal)
    }
}

struct FlightInfoPanel: View {
    var flight: FlightInformation
    @State private var showTerminal = false

    var timeFormatter: DateFormatter {
        let tdf = DateFormatter()
        tdf.timeStyle = .short
        tdf.dateStyle = .none
        return tdf
    }

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 35, height: 35, alignment: .leading)
            VStack(alignment: .leading) {
                Text("Flight Details")
                    .font(.title2)
                if flight.direction == .arrival {
                    Text("Arriving at Gate \(flight.gate)")
                    Text("Flying from \(flight.otherAirport)")
                } else {
                    Text("Departing from Gate \(flight.gate)")
                    Text("Flying to \(flight.otherAirport)")
                }
                Text(flight.flightStatus) + Text(" (\(timeFormatter.string(from: flight.localTime)))")
                Button {
                    withAnimation {
                        showTerminal.toggle()
                    }
                } label: {
                    HStack {
                        Group {
                            if showTerminal {
                                Text("Hide Terminal Map")
                            } else {
                                Text("Show Terminal Map")
                            }
                        }
                        .transition(.move(edge: .bottom))
                        Spacer()
                        Image(systemName: "airplane.circle")
                            .imageScale(.large)
                            .padding(10)
                            .rotationEffect(.degrees(showTerminal ? 90 : 270))
                            .scaleEffect(showTerminal ? 1.5 : 1.0)
                            .animation(.spring(response: 0.55, dampingFraction: 0.45, blendDuration: 0), value: showTerminal)
                    }
                }
                if showTerminal {
                    TerminalMapView(flight: flight)
                        .transition(.buttonNameTransition)
                }
                Spacer()
            }
        }
    }
}

struct FlightInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoPanel(
            flight: FlightData.generateTestFlight(date: Date())
        )
    }
}
