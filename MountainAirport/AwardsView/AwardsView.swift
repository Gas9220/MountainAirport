//
//  AwardsView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct AwardsView: View {
    @Namespace var cardNamespace
    @EnvironmentObject var flightNavigation: AppEnvironment
    @State private var selectedAward: AwardInformation?
    var awardArray: [AwardInformation] {
        flightNavigation.awardList
    }

    var awardColumns: [GridItem] {
        [
            GridItem(.adaptive(minimum: 150, maximum: 170))
        ]
    }

    var activeAwards: [AwardInformation] {
        awardArray.filter { $0.awarded }
    }

    var inactiveAwards: [AwardInformation] {
        awardArray.filter { !$0.awarded }
    }

    var body: some View {
        ZStack {
            if let award = selectedAward {
                AwardDetails(award: award)
                    .background(Color.white)
                    .shadow(radius: 5.0)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .onTapGesture {
                        withAnimation {
                            selectedAward = nil
                        }
                    }
                    .matchedGeometryEffect(id: award.hashValue, in: cardNamespace, anchor: .topLeading)
                    .navigationTitle(award.title)
            } else {
                ScrollView {
                    LazyVGrid(columns: awardColumns) {
                        AwardGrid(
                            selected: $selectedAward,
                            title: "Awarded",
                            awards: activeAwards,
                            namespace: cardNamespace
                        )
                        AwardGrid(
                            selected: $selectedAward,
                            title: "Not Awarded",
                            awards: inactiveAwards,
                            namespace: cardNamespace
                        )
                    }
                }
                .navigationTitle("Your Awards")
            }
        }
        .background(
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
            .environmentObject(AppEnvironment())
    }
}
