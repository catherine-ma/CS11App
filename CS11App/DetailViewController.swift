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
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    var descript: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let detail = descript {
            detailField.text = detail
        }
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
