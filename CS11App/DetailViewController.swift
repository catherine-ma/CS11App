//
//  DetailViewController.swift
//  CS11App
//
//  Created by Cathy on 11/13/17.
//  Copyright © 2017 Catherine Ma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailField: UITextView!
    
    var descript: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let detail = descript {
            detailField.text = detail
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
