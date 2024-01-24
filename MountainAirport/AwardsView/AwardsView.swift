//
//  AwardsView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject var flightNavigation: AppEnvironment
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
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: awardColumns, spacing: 15) {
                    AwardGrid(title: "Awarded", awards: activeAwards)
                    AwardGrid(title: "Not Awarded", awards: inactiveAwards)
                }
                .navigationDestination(for: AwardInformation.self) { award in
                    AwardDetails(award: award)
                }
                .font(.title)
                .foregroundStyle(.white)
                .padding()
            }
            .navigationTitle("Your Awards")
            .padding()
            .background(
                Image("background-view")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
            .environmentObject(AppEnvironment())
    }
}
