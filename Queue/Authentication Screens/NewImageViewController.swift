//
//  NewImageViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/24/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit
import Photos

class NewImageViewController: QueueUI.ViewController {

    @IBOutlet weak var chooseImgBtn: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var continueButton: QueueUI.Button!
    
    private var imgPickController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImagePicker()
    }
    
    private func setupView() {
        chooseImgBtn.layer.borderWidth = 4
        chooseImgBtn.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        continueButton.setDisabled()
    }
    
    private func setupImagePicker() {
        imgPickController = UIImagePickerController()
        imgPickController.delegate = self
        imgPickController.allowsEditing = true
        imgPickController.mediaTypes = ["public.image"]
        imgPickController.sourceType = .photoLibrary
    }
    
    @IBAction func chooseImgBtnTouched(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                if let this = self {
                    switch status {
                    case .authorized:    this.handleAuthorize()
                    case .notDetermined: if status == .authorized { this.handleAuthorize() }
                    case .restricted:    this.handleRestricted()
                    case .denied:        this.handleDenied()
                    @unknown default:
                        fatalError()
                    }
                }
            }
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "newImageToNewPassword", sender: nil)
    }
    
    
    private func handleAuthorize() {
        DispatchQueue.main.async {
            self.present(self.imgPickController!, animated: true)
        }
    }
    
    private func handleRestricted() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Photo Library Restricted",
                                          message: "Photo Library access is restricted and cannot be accessed.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    private func handleDenied() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Photo Library Denied",
                                          message: "Photo Library access was previously denied and cannot be accessed.",
                                          preferredStyle: .alert)
            let gotoSettingAction = UIAlertAction(title: "Go to Setting", style: .default) {
                _ in
                DispatchQueue.main.async {
                    let url = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(url, options: [:])
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(gotoSettingAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        } 
    }
    
    
}

extension NewImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            userImageView.image = image
            chooseImgBtn.setImage(UIImage(), for: .normal)
            chooseImgBtn.layer.borderWidth = 0.0
            continueButton.setActive()
        }
        dismiss(animated: true)
    }
}


