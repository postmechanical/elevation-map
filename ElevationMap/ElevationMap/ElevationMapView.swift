//
//  ElevationMapView.swift
//  ElevationMap
//
//  Created by Aaron London on 2/1/19.
//  Copyright © 2019 postmechanical. All rights reserved.
//

import UIKit

class ElevationMapView: UIView {
    let colors = [
        0: UIColor.blue,
        1: UIColor.green,
        2: UIColor.green,
        3: UIColor.green,
        4: UIColor.green,
        5: UIColor.green,
        6: UIColor.green,
        7: UIColor.green,
        8: UIColor.green,
        9: UIColor.green,
        10: UIColor.green,
        11: UIColor.green,
        12: UIColor.green,
        13: UIColor.green,
        14: UIColor.green,
        15: UIColor.green,
        16: UIColor.green,
        17: UIColor.green,
        18: UIColor.green,
        19: UIColor.green,
        20: UIColor.white
    ]
    
    private(set) var didRender = false

    func render(_ map: [[Int]]) {
        guard !didRender else { return }
        let dimension = map.count
        let size = bounds.width / CGFloat(dimension)
        subviews.forEach { $0.removeFromSuperview() }
        for (r, row) in map.enumerated() {
            for (c, elevation) in row.enumerated() {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = color(for: elevation)
                addSubview(view)
                NSLayoutConstraint.activate([
                    view.heightAnchor.constraint(equalToConstant: size),
                    view.widthAnchor.constraint(equalToConstant: size),
                    view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(c) * size),
                    view.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(r) * size)
                    ])
            }
        }
        didRender = true
    }
    
    func color(for elevation: Int) -> UIColor {
        switch elevation {
        case 0: return UIColor.blue
        case 20: return UIColor.white
        default: return UIColor(red: 0.0, green: 1.0/CGFloat(elevation), blue: 0.0, alpha: 1.0)
        }
    }
}
