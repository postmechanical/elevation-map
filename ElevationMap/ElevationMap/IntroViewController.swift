//
//  IntroViewController.swift
//  ElevationMap
//
//  Created by Aaron London on 3/6/19.
//  Copyright © 2019 postmechanical. All rights reserved.
//

import UIKit

typealias ElevationMap = [[Int]]

class IntroViewController: UIViewController {
    var maps = [String: ElevationMap]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMaps()
    }

    func loadMaps() {
        guard
            let url = Bundle.main.url(forResource: "elevation-maps", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let maps = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: ElevationMap]
            else { return }
        self.maps = maps!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let identifier = segue.identifier,
            let elevationMapViewController = segue.destination as? ElevationMapViewController,
            let map = maps[identifier]
            else { return }
        elevationMapViewController.title = identifier
        elevationMapViewController.map = map
    }
}
