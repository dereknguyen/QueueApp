import UIKit
import Photos

class NewClubImageViewController: UIViewController, UserSelectImageController {
    
    var imgPickerController: UIImagePickerController!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var clubLogoImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var continueButton: QueueUI.Button!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBAction func selectImageTouched(_ sender: UIButton) {
        requestPermissionPresentImagePicker(in: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
        setupView()
    }
    
    func setupView() {
        selectImageButton.layer.borderWidth = 4
        selectImageButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        continueButton.setButton(title: "Create Club", state: .disabled)
    }
    
    func setupImagePicker() {
        imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        imgPickerController.allowsEditing = true
        imgPickerController.mediaTypes = ["public.image"]
        imgPickerController.sourceType = .photoLibrary
        imgPickerController.modalTransitionStyle = .coverVertical
        imgPickerController.modalPresentationStyle = .overFullScreen
    }
}

extension NewClubImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[.editedImage] as? UIImage {
            clubLogoImageView.image = image
            selectImageButton.setImage(UIImage(), for: .normal)
            selectImageButton.layer.borderWidth = 0.0
            continueButton.setButton(state: .active)
        }
        dismiss(animated: true)
    }
}
