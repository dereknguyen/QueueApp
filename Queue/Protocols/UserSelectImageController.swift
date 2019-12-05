import UIKit
import Photos

/// Protocol to implement to handle Image Picker Controller and its authorization status.
protocol UserSelectImageController: class {
    
    /// Image Picker Controller that will be presented to user. Must be initialized.
    var imgPickerController: UIImagePickerController! { get set }
}

extension UserSelectImageController {
    
    /// Handle authorization cases and present a permision request alert to access user's photo library to pick an image.
    /// - parameter in: The view controller that permission request alert will be presented in.
    func requestPermissionPresentImagePicker(in viewControler: UIViewController) {
        
        // Check if Photo Library is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            // Request authorization to access Photo Library
            PHPhotoLibrary.requestAuthorization {
                [weak self] status in
                
                if let this = self {
                    switch status {
                    case .authorized:                           // Authorized
                        this.handleAuthorize(viewControler)
                    case .notDetermined:                        // Not Determined
                        if status == .authorized {
                            this.handleAuthorize(viewControler)
                        }
                    case .restricted:                           // Restricted
                        this.handleRestricted(viewControler)
                    case .denied:                               // Denied
                        this.handleDenied(viewControler)
                    @unknown default:                           // TODO: Gracefully handle unknown
                        fatalError()
                    }
                }
            }
        }
    }
    
    // Handle Authorization: Present Image Picker
    private func handleAuthorize(_ vc: UIViewController) {
        DispatchQueue.main.async {
            [weak self] in
            if let this = self {
                vc.present(this.imgPickerController, animated: true)
            }
            else {
                fatalError("UserSelectImageViewController: self is nil when unwrapped.")
            }
        }
    }
    
    // Handle Restricted: Present an alert notified that Photo Library accesss is restricted.
    private func handleRestricted(_ vc: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Photo Library Restricted",
                message: "Photo Library access is restricted and cannot be accessed.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            vc.present(alert, animated: true)
        }
    }
    
    // Handle Denied: Present an alert notified user that Photo Library access is denied.
    // Offers user:
    //      1. Go to setting to change Photo Library accesss status.
    //      2. Ignore and do nothing.
    private func handleDenied(_ vc: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Photo Library Denied",
                message: "Photo Library access was previously denied and cannot be accessed.",
                preferredStyle: .alert
            )
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
            vc.present(alert, animated: true)
        }
    }
}
