//
//  ViewController.swift
//  CS11App
//
//  Created by Cathy on 10/26/17.
//  Copyright © 2017 Catherine Ma. All rights reserved.
//

import UIKit

class NewCacheViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var creatorField: UITextField!
    @IBOutlet weak var rewardField: UITextField!
    
    var cache: GeoCache?
    var picker = UIImagePickerController()
    
    @IBAction func imagePicker(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    @IBOutlet weak var imagePreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePreview.image = selectedImage
            imagePreview?.contentMode = .scaleAspectFit
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        
        let image = imagePreview.image as Any

        cache = GeoCache(fromDictionary: ["id": randomCacheId(), "title" : title, "details" : detail, "creator" : creator, "reward" : reward, "image": image])
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        cache = nil
        dismiss(animated: true, completion: nil)
    }
}
