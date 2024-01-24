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

    @State private var checkInFlight: CheckInInfo?
    @State private var showCheckIn = false
    @State private var showFlightHistory = false

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

                if flight.isCheckInAvailable {
                    Button("Check In for Flight") {
                        checkInFlight = CheckInInfo(airline: flight.airline, flight: flight.number)
                        showCheckIn = true
                    }
                    .confirmationDialog(
                        "Check In",
                        isPresented: $showCheckIn,
                        presenting: checkInFlight
                    ) { checkIn in
                        Button("Check In") {
                            print(
                                "Check-in for \(checkIn.airline) \(checkIn.flight)."
                            )
                        }
                        Button("Reschedule", role: .destructive) {
                            print("Reschedule flight.")
                        }
                        Button("Not Now", role: .cancel) { }
                    } message: { checkIn in
                        Text("Check in for \(checkIn.airline)" +
                             "Flight \(checkIn.flight)")
                    }
                }

                Button("On-Time History") {
                    showFlightHistory.toggle()
                }
                .popover(isPresented: $showFlightHistory, arrowEdge: .top) {
                    FlightTimeHistory(flight: flight)
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
