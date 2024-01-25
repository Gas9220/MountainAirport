//
//  HistoryChartView.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 25/01/24.
//

import SwiftUI
import Charts

struct HistoryChartView: View {
    var flightHistory: [FlightHistory]

    func barGradientColors(_ history: FlightHistory) -> Gradient {
        if history.status == .canceled {
            return Gradient(
                colors: [
                    Color.green,
                    Color.yellow,
                    Color.red,
                    Color(red: 0.5, green: 0, blue: 0)
                ] )
        }
        if history.timeDifference <= 0 {
            return Gradient(colors: [Color.green])
        }
        if history.timeDifference <= 15 {
            return Gradient(colors: [Color.green, Color.yellow])
        }
        return Gradient(
            colors: [Color.green, Color.yellow, Color.red]
        )
    }

    var body: some View {
        Chart {
            ForEach(flightHistory, id: \.self) { history in
                BarMark(x: .value("Minutes", history.timeDifference),
                        y: .value("Days Ago", "\(history.day) day(s) ago"))
                .foregroundStyle(
                    LinearGradient(gradient: barGradientColors(history),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .annotation(position: .overlay) {
                    Text(history.flightDelayDescription)
                        .font(.caption)
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: [-10, 0, 10, 20, 30, 40, 50, 60]) { value in
                AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 1.0, dash: [5.0, 5.0]))
                    .foregroundStyle(.white.opacity(0.8))

                AxisValueLabel() {
                    if let value = value.as(Int.self) {
                        Text(value, format: .number)
                            .foregroundStyle(Color.white.opacity(0.8))
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { value in
                AxisGridLine(centered: false, stroke: StrokeStyle(lineWidth: 1.0))
                    .foregroundStyle(Color.white.opacity(0.8))
                AxisValueLabel() {
                    if let value = value.as(String.self) {
                        Text(value)
                            .font(.footnote)
                            .foregroundColor(Color.white.opacity(0.8))
                    }
                }
            }
        }
        .chartYAxisLabel {
            Text("Delay in minutes")
                .foregroundStyle(.white)
                .font(.callout)
        }
        .chartXScale(domain: -18...63)
    }
}

#Preview {
    HistoryChartView(flightHistory: FlightData.generateTestFlight(date: Date()).history)
}
