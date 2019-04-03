//
//  ViewController.swift
//  Videos
//
//  Created by Will Said on 4/2/19.
//  Copyright © 2019 Will Said. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    
    // the imagePicker we will present
    var imagePicker: UIImagePickerController!
    
    
    // tap on this imageView to load a photo into it
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupImagePicker()
        self.setupImageView()
    }
    
    
    @objc func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.setupImagePicker()
            self.present(imagePicker, animated: true)
        } else {
            // you're using a simulator - not allowed
        }
    }
    
    func setupImagePicker() {
        self.imagePicker = UIImagePickerController() // initialize the image picker
        self.imagePicker.delegate = self             // set UIImagePickerControllerDelegate = self (See extension with conformance below!)
        self.imagePicker.sourceType = .camera        // or use .photoLibrary to access a user's photo library
        imagePicker.videoQuality = .typeHigh
        imagePicker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String] // lets you record AND take a photo
        imagePicker.allowsEditing = true // trimming a video
        imagePicker.cameraDevice = .rear // .rear or .front
    }
    
    // you could've also just made a separate button that linked to takePhoto
    func setupImageView() {
        self.imageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(takePhoto)))
        self.imageView.isUserInteractionEnabled = true
    }


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // dimiss the imagePicker
        imagePicker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // you took/chose a photo
            self.imageView.image = selectedImage
            UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
        }
        
        
        if let pickedVideo: URL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            
            // you took a video
            
            UISaveVideoAtPathToSavedPhotosAlbum(pickedVideo.relativePath, nil, nil, nil)
        }
        
        
        
    }
    
}
