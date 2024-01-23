//
//  FlightDirectionGraphic.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct FlightDirectionGraphic: View {
    var direction: FlightDirection

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color(red: 0.9, green: 0.4, blue: 0.69))
            Image(systemName: "airplane")
                .resizable()
                .padding(5)
                .rotationEffect(.degrees(direction == .arrival ? 45.0 : -45.0))
        }
    }
}

struct FlightDirectionGraphic_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlightDirectionGraphic(direction: .arrival)
            FlightDirectionGraphic(direction: .departure)
        }.frame(width: 50, height: 50)
    }
}
