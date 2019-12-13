import UIKit
import Photos

class NewImageViewController: UIViewController, UserSelectImageController {
    
    var imgPickerController: UIImagePickerController!
    
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
        continueButton.setButton(style: .disabled)
    }
    
    private func setupImagePicker() {
        imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        imgPickerController.allowsEditing = true
        imgPickerController.mediaTypes = ["public.image"]
        imgPickerController.sourceType = .photoLibrary
        imgPickerController.modalTransitionStyle = .coverVertical
        imgPickerController.modalPresentationStyle = .overFullScreen
    }
    
    @IBAction func chooseImgBtnTouched(_ sender: UIButton) {
        requestPermissionPresentImagePicker(in: self)
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "newImageToNewPassword", sender: nil)
    }
}

extension NewImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[.editedImage] as? UIImage {
            userImageView.image = image
            chooseImgBtn.setImage(UIImage(), for: .normal)
            chooseImgBtn.layer.borderWidth = 0.0
            continueButton.setButton(style: .active)
        }
        dismiss(animated: true)
    }
}


