//
//  SearchViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 12/9/20.
//

import UIKit
import Parse

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users = [PFObject]()
    var currUser = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        currUser = PFUser.current()!
        getUsers()
    }
    
    func getUsers() {
        let query = PFUser.query()
        query?.limit = 20
        query?.whereKey("objectId", notEqualTo: currUser)
        self.users = try! query!.findObjects()
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let potentialBuddy = users[indexPath.row] as! PFUser
        
        if potentialBuddy["profileImage"] != nil {
            let imageFile = potentialBuddy["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.userImageView.af.setImage(withURL: url)
        }
        
        cell.usernameLabel.text = potentialBuddy["username"] as? String
        cell.nameLabel.text = potentialBuddy["name"] as? String
        
        return cell
    }
}
