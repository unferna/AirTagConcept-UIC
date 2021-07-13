//
//  RoundedCorner.swift
//  AirTagConcept
//
//  Created by Fernando Florez on 11/07/21.
//

import SwiftUI

struct RoundedCorners: View {
    var color: Color = .blue
    var topLeft: CGFloat = 0
    var topRight: CGFloat = 0
    var bottomLeft: CGFloat = 0
    var bottomRight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                let tLeft = min(min(topLeft, height / 2), width / 2)
                let tRight = min(min(topRight, height / 2), width / 2)
                let bLeft = min(min(bottomLeft, height / 2), width / 2)
                let bRight = min(min(bottomRight, height / 2), width / 2)
                
                path.move(to: CGPoint(x: width / 2, y: 0))
                path.addLine(to: CGPoint(x: width - tRight, y: 0))
                path.addArc(center: CGPoint(x: width - tRight, y: tRight), radius: tRight, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                
                path.addLine(to: CGPoint(x: width, y: height - bRight))
                path.addArc(center: CGPoint(x: width - bRight, y: height - bRight), radius: bRight, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                
                path.addLine(to: CGPoint(x: bLeft, y: height))
                path.addArc(center: CGPoint(x: bLeft, y: height - bLeft), radius: bLeft, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                
                path.addLine(to: CGPoint(x: 0, y: tLeft))
                path.addArc(center: CGPoint(x: tLeft, y: tLeft), radius: tLeft, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(color, style: FillStyle(eoFill: true))
        }
    }
}
