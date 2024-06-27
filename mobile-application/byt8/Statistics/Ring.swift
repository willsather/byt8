//
//  Ring.swift
//  Bytes
//
//  Created by Will Sather on 6/15/21.
//

import Foundation
import SwiftUI

struct Ring: Shape {

    var progress: Double = 0.0
    var thickness: Double = 25.0

    func path(in rect: CGRect) -> Path {

        let halfThickness = CGFloat(thickness / 2.0)
        let rect = rect.insetBy(dx: halfThickness, dy: halfThickness)

        return Path() {
            $0.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                      radius: min(rect.width, rect.height) / 2,
                      startAngle: Angle(degrees: -90),
                      endAngle: Angle(degrees: -90 + 360 * progress),
                      clockwise: false)
        }.strokedPath(StrokeStyle(lineWidth: CGFloat(thickness), lineCap: .round))
    }

    var animatableData: Double {
        get { progress }
        set { progress = min(1.0, max(0, newValue)) }
    }
}
