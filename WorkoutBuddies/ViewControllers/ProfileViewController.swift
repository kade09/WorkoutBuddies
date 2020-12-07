//
//  ProfileViewController.swift
//  WorkoutBuddies
//
//  Created by Tiffany Lee on 12/5/20.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.isUserInteractionEnabled = true
    }
}
