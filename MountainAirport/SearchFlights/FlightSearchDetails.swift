//
//  FlightSearchDetails.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 24/01/24.
//

import SwiftUI

struct FlightSearchDetails: View {
    @Binding var showModal: Bool
    @State private var rebookAlert = false
    var flight: FlightInformation
    @EnvironmentObject var lastFlightInfo: AppEnvironment

    @State private var phone = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .leading) {
                HStack {
                    FlightDetailHeader(flight: flight)
                    Spacer()
                    Button("Close") {
                        showModal = false
                    }
                }

                if flight.status == .canceled {
                    Button("Rebook Flight") {
                        rebookAlert = true
                    }
                    .alert("Contact your airline", isPresented: $rebookAlert) {
                        TextField("Phone", text: $phone)
                            .textContentType(.telephoneNumber)
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                        Button("Call Me") {
                        }
                        Button("Cancel", role: .cancel) {
                        }
                    } message: {
                        Text("We cannot rebook this flight.") +
                        Text("Please enter your phone number and confirm your password.")
                    }
                }


                FlightInfoPanel(flight: flight)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20.0)
                            .opacity(0.3)
                    )
                Spacer()
            }.foregroundColor(.white)
                .padding()
        }
        .interactiveDismissDisabled()
        .onAppear {
            lastFlightInfo.lastFlightId = flight.id
        }
    }
}

struct FlightSearchDetails_Previews: PreviewProvider {
    static var previews: some View {
        FlightSearchDetails(
            showModal: .constant(true), flight: FlightData.generateTestFlight(date: Date())
        ).environmentObject(AppEnvironment())
    }
}
