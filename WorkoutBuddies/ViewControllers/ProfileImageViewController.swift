//
//  ProfileImageViewController.swift
//  WorkoutBuddies
//
//  Created by Tiffany Lee on 12/5/20.
//

import UIKit
import AlamofireImage
import Parse

class ProfileImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
    }

    @IBAction func onDoneButton(_ sender: Any) {
        let user = PFUser.current()!
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        user["profileImage"] = file
            
        user.saveInBackground()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        view.endEditing(true)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector(("imagePickerController")))
           self.view.addGestureRecognizer(tapGesture)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.isUserInteractionEnabled = true
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
}
