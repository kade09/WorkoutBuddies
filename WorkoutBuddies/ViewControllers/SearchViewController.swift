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
    var filteredUsers = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.placeholder = "Search by username or name"
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        currUser = PFUser.current()!
        getUsers()
    }
    
    func getUsers() {
        let query = PFUser.query()
        query?.limit = 20
        query?.whereKey("user", notEqualTo: currUser)
        self.users = try! query!.findObjects()
        self.filteredUsers = self.users
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let potentialBuddy = filteredUsers[indexPath.row] as! PFUser
        
        if potentialBuddy["profileImage"] != nil {
            let imageFile = potentialBuddy["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.userImageView.af.setImage(withURL: url)
        }
        
        cell.usernameLabel.text = potentialBuddy["username"] as? String
        cell.nameLabel.text = potentialBuddy["name"] as? String
        cell.levelLabel.text = potentialBuddy["workoutLevel"] as? String
        cell.countWorkoutsLabel.text = "2"
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = searchText.isEmpty ? users : users.filter {
            (user: PFObject) -> Bool in
            let updatedUser = user as! PFUser
            let updatedUsername = updatedUser.username!
            let updatedName = updatedUser["name"] as! String
            
            let inUsername = updatedUsername.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            let inName = updatedName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
            return inUsername || inName
        }
        
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
