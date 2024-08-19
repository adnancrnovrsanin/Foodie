//
//  EarningsLineChartView.swift
//  Foodie
//
//  Created by Muhedin Alic on 19.08.24.
//

import SwiftUI
import Charts

struct EarningsLineChartView: View {
    let earningsData: [EarningsData]
        
    var body: some View {
        Chart(earningsData) { data in
            LineMark(
                x: .value("Date", data.date),
                y: .value("Earnings", data.earnings.amount)
            )
            .foregroundStyle(Color.blue)
            .interpolationMethod(.catmullRom)
        }
        .chartYAxis {
            AxisMarks(preset: .automatic, position: .leading)
        }
    }
}
