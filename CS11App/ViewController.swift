//
//  ViewController.swift
//  CS11App
//
//  Created by Cathy on 10/26/17.
//  Copyright © 2017 Catherine Ma. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var creatorField: UITextField!
    @IBOutlet weak var rewardField: UITextField!
    @IBOutlet weak var cacheLabel: UITextView!
    
    var geoCaches: [GeoCache] = []
    var currIdx: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geoCaches = loadCachesFromDefaults()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addGeoCache(_ sender: Any) {
        guard let title = titleField.text, title != "" else {
            cacheLabel.text = "No title"
            return
        }
        
        guard let detail = detailField.text, detail != "" else {
            cacheLabel.text = "No details"
            return
        }
        
        guard let creator = creatorField.text, creator != "" else {
            cacheLabel.text = "No creator"
            return
        }
        
        guard let reward = rewardField.text, reward != "" else {
            cacheLabel.text = "No reward"
            return
        }
        
        let newGeoCache: GeoCache? = GeoCache(fromDictionary: ["title" : title, "details" : detail, "creator" : creator, "reward" : reward])
        geoCaches.append(newGeoCache!)
        saveCachesToDefaults(geoCaches)
    }
    
    @IBAction func nextCache(_ sender: Any) {
        if geoCaches.count != 0 {
            if currIdx == geoCaches.count - 1 {
                currIdx = 0
                cacheLabel.text = geoCaches[currIdx].description
            }
            else {
                currIdx += 1
                cacheLabel.text = geoCaches[currIdx].description
            }
        }
    }
}
