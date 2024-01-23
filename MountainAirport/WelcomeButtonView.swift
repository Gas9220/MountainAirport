//
//  WelcomeButtonView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import SwiftUI

struct WelcomeButtonView: View {
    var title: String
    var subTitle: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
            Text(subTitle)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Image("link-pattern")
                .resizable()
                .clipped()
        )
    }
}

#Preview {
    WelcomeButtonView(title: "Flight Status", subTitle: "Departure and Arrival Information")
}
