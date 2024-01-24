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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(awardArray, id: \.self) { award in
                        NavigationLink(value: award) {
                            AwardCardView(award: award)
                                .foregroundColor(.black)
                                .frame(width: 150, height: 220)
                        }
                    }
                    .navigationDestination(for: AwardInformation.self) { award in
                        AwardDetails(award: award)
                    }
                }
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
