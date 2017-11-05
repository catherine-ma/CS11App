//
//  GeoCache.swift
//  CS11App
//
//  Created by Cathy on 11/5/17.
//  Copyright © 2017 Catherine Ma. All rights reserved.
//

import Foundation

struct GeoCache {
    var title: String
    var details: String
    var creator: String
    var reward: String
    
    init?(fromDictionary dict: [String: String]) {
        guard let initTitle = dict["title"], initTitle != "" else {
            return nil
        }
        
        guard let initDetails = dict["details"], initDetails != "" else {
            return nil
        }
        
        guard let initCreator = dict["creator"], initCreator != "" else {
            return nil
        }
        
        guard let initReward = dict["reward"], initReward != "" else {
            return nil
        }
        
        self.title = initTitle
        self.details = initDetails
        self.creator = initCreator
        self.reward = initReward
    }
    
    var dictionary: [String: String] {
        get {
            return ["title": title, "details": details, "creator": creator, "reward": reward]
        }
        set {
            title = newValue["title"]!
            details = newValue["details"]!
            creator = newValue["creator"]!
            reward = newValue["reward"]!
        }
    }
    
    var description: String {
        get {
            return "\(title): located at \(details) with reward \(reward). Created by \(creator)."
        }
    }
}

func loadCachesFromDefaults() -> [GeoCache] {
    let defaults = UserDefaults.standard
    var geoArr: [GeoCache] = []
    
    if let geoCacheArr: [[String: String]] = defaults.array(forKey: "arr") as? [[String: String]] {
        for dict in geoCacheArr {
            let geoDict: [String: String] = dict
            
            if let geoCache: GeoCache = GeoCache(fromDictionary: geoDict) {
                geoArr.append(geoCache)
            }
        }
    }
    
    return geoArr
}

func saveCachesToDefaults(_ caches: [GeoCache]) {
    let defaults = UserDefaults.standard
    var geoArr: [[String: String]] = []
    
    for geo in caches {
        let geoDict: [String: String] = geo.dictionary
        geoArr.append(geoDict)
    }
    
    defaults.setValue(geoArr, forKey: "arr")
    defaults.synchronize()
}
