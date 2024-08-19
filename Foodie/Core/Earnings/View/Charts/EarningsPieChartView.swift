//
//  EarningsPieChartView.swift
//  Foodie
//
//  Created by Muhedin Alic on 19.08.24.
//

import SwiftUI
import Charts

struct EarningsPieChartView: View {
    let successfulOrders: Int
    let canceledOrders: Int
    
    var totalOrders: Int {
        successfulOrders + canceledOrders
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let radius = size / 2
            let successfulAngle = Angle(degrees: Double(successfulOrders) / Double(totalOrders) * 360)
            let canceledAngle = Angle(degrees: Double(canceledOrders) / Double(totalOrders) * 360)
            
            ZStack {
                PieSlice(startAngle: .zero, endAngle: successfulAngle)
                    .fill(Color.green)
                
                PieSlice(startAngle: successfulAngle, endAngle: .zero + canceledAngle)
                    .fill(Color.red)
            }
            .frame(width: size, height: size)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct PieSlice: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}
