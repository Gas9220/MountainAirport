//
//  AwardGrid.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct AwardGrid: View {
    @Binding var selected: AwardInformation?
    var title: String
    var awards: [AwardInformation]
    var namespace: Namespace.ID

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
                AwardCardView(award: award)
                    .foregroundColor(.black)
                    .aspectRatio(0.67, contentMode: .fit)
                    .onTapGesture {
                        withAnimation {
                            selected = award
                        }
                    }
                    .matchedGeometryEffect(id: award.hashValue, in: namespace, anchor: .topLeading)
            }
        }
    }
}

#Preview {
    @Namespace var namespace
    return AwardGrid(selected: .constant(nil), title: "Test", awards: AppEnvironment().awardList, namespace: namespace)
}
