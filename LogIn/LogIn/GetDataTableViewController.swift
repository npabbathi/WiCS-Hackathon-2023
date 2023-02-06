//
//  GetDataTableViewController.swift
//  LogIn
//
//  Created by Nidhi Pabbathi on 2/4/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class GetDataTableViewController: UITableViewController {
    let users = ["Ananya", "Allison", "Karnika", "Carol", "Mike", "Kate", "Angela", "Vaishnavi", "Nithya", "Korn"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count - 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = users[Int.random(in: 0 ..< users.count)]
        return cell
    }

   


}
