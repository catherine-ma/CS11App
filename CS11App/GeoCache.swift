//
//  GeoCache.swift
//  CS11App
//
//  Created by Cathy on 11/5/17.
//  Copyright © 2017 Catherine Ma. All rights reserved.
//

import Foundation

struct GeoCache {
    var id: Int
    var title: String
    var details: String
    var creator: String
    var reward: String
    
    init?(fromDictionary dict: [String: Any]) {
        guard let initID = dict["id"] as? Int else {
            return nil
        }
        
        guard let initTitle = dict["title"] as? String, initTitle != "" else {
            return nil
        }
        
        guard let initDetails = dict["details"] as? String, initDetails != "" else {
            return nil
        }
        
        guard let initCreator = dict["creator"] as? String, initCreator != "" else {
            return nil
        }
        
        guard let initReward = dict["reward"] as? String, initReward != "" else {
            return nil
        }
        
        self.id = initID
        self.title = initTitle
        self.details = initDetails
        self.creator = initCreator
        self.reward = initReward
    }
    
    var dictionary: [String: Any] {
        get {
            return ["id": id, "title": title, "details": details, "creator": creator, "reward": reward]
        }
        set {
            id = newValue["id"] as! Int
            title = newValue["title"] as! String
            details = newValue["details"] as! String
            creator = newValue["creator"] as! String
            reward = newValue["reward"] as! String
        }
    }
    
    var description: String {
        get {
            return "\(title): located at \(details) with reward \(reward). Created by \(creator)."
        }
    }
}

func randomCacheId() -> Int {
    return Int(arc4random())
}

func sendCacheToServer(_ cache: GeoCache) {
    let dest: URL? = URL(string: "http://localhost:5000/createCache")
    var request = URLRequest(url: dest!)
    request.httpMethod = "POST"
    let data = try? JSONSerialization.data(withJSONObject: cache.dictionary)
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) {
        data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
    }
    task.resume()
}

func loadCachesFromServer(onComplete: @escaping ([GeoCache]) -> ()) {
    let dest: URL? = URL(string: "http://localhost:5000/getCaches")
    var request = URLRequest(url: dest!)
    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request) {
        data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else {
            return
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]] {
            var geoCacheArr: [GeoCache] = []
            
            for dict in json! {
                let geoCache: GeoCache = GeoCache(fromDictionary: dict)!
                geoCacheArr.append(geoCache)
            }
            
            onComplete(geoCacheArr)
        }
    }
    task.resume()
}
