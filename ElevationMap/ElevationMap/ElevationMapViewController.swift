//
//  ElevationMapViewController.swift
//  ElevationMap
//
//  Created by Aaron London on 2/1/19.
//  Copyright © 2019 postmechanical. All rights reserved.
//

import UIKit

struct Index: Equatable, Hashable {
    let row: Int
    let cell: Int
}

class ElevationMapViewController: UIViewController {
    
    var map = ElevationMap()
    @IBOutlet var mapView: ElevationMapView!
    @IBOutlet var islandCountLabel: UILabel!

    override func viewDidLayoutSubviews() {
        mapView.render(map)
        DispatchQueue.global(qos: .userInitiated).async {
            let count = self.numberOfIslands(in: self.map)
            DispatchQueue.main.async {
                self.islandCountLabel?.text = "Islands: \(count)"
            }
        }
    }
    
    func numberOfIslands(in map: ElevationMap) -> Int {
        var visited = [Index]()
        var count = 0
        for (r, row) in map.enumerated() {
            for (c, elevation) in row.enumerated() {
                let index = Index(row: r, cell: c)
                if elevation > 0, !visited.contains(index) {
                    visited.append(contentsOf: visit(map, from: index, visited: visited))
                    count += 1
                }
            }
        }
        return count
    }
    
    func visit(_ map: ElevationMap, from index: Index, visited: [Index]) -> [Index] {
        var thisVisited = visited
        thisVisited.append(index)
        neighbors(of: index, in: map).forEach { idx in
            guard map[idx.row][idx.cell] > 0, !thisVisited.contains(idx) else { return }
            thisVisited.append(contentsOf: visit(map, from: idx, visited: thisVisited))
        }
        return thisVisited
    }
    
    func neighbors(of index: Index, in map: ElevationMap) -> [Index] {
        var neighbors = [Index]()
        if index.row > 0 {
            neighbors.append(Index(row: index.row - 1, cell: index.cell))
        }
        if index.cell > 0 {
            neighbors.append((Index(row: index.row, cell: index.cell - 1)))
        }
        if index.row < map.count - 1 {
            neighbors.append(Index(row: index.row + 1, cell: index.cell))
        }
        if index.cell < map[index.row].count - 1 {
            neighbors.append(Index(row: index.row, cell: index.cell + 1))
        }
        return neighbors
    }
}

