//
//  AwardGrid.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct AwardGrid: View {
    var title: String
    var awards: [AwardInformation]

    var body: some View {
        Section(
            header: Text(title)
                .frame(maxWidth: .infinity)
                .font(.title)
                .foregroundColor(.white)
                .background(
                    .ultraThinMaterial,
                    in: RoundedRectangle(cornerRadius: 10)
                )
        ) {
            ForEach(awards) { award in
                NavigationLink(value: award) {
                    AwardCardView(award: award)
                        .foregroundColor(.black)
                        .aspectRatio(0.67, contentMode: .fit)
                }
            }
        }
    }
}
