//
//  HomeViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 11/28/20.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController {
    @IBOutlet weak var sugguestionsCollectionView: UICollectionView!
    @IBOutlet weak var workoutsCollectionView: UICollectionView!
    

    var mates = [PFObject]()
    var otherWorkouts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMates()
    }
    
    func getMates() {
        let query = PFUser.query()
        query!.limit = 20
        let users = try! query?.findObjects()
        mates = users!
    }
}
