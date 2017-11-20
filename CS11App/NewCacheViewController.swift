//
//  ViewController.swift
//  CS11App
//
//  Created by Cathy on 10/26/17.
//  Copyright © 2017 Catherine Ma. All rights reserved.
//

import UIKit

class NewCacheViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var creatorField: UITextField!
    @IBOutlet weak var rewardField: UITextField!
    
    var cache: GeoCache?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let title = titleField.text, title != "" else {
            return
        }

        guard let detail = detailField.text, detail != "" else {
            return
        }

        guard let creator = creatorField.text, creator != "" else {
            return
        }

        guard let reward = rewardField.text, reward != "" else {
            return
        }

        cache = GeoCache(fromDictionary: ["id": randomCacheId(), "title" : title, "details" : detail, "creator" : creator, "reward" : reward])
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        cache = nil
        dismiss(animated: true, completion: nil)
    }
}
