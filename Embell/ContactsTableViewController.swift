//
//  ContactsTableViewController.swift
//  Embell
//
//  Created by Jonathon F Vega on 3/13/17.
//  Copyright © 2017 Jonathon Vega. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ContactsTableViewController: UITableViewController, UISearchResultsUpdating {

    @IBOutlet var userContactsTableView: UITableView!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var contactsArray = [NSDictionary?]()
    var filteredContacts = [NSDictionary?]()
    
    var databaseRef = FIRDatabase.database().reference()
    
    
    // User ID to pass for segue from selected cell
    var contactIDToPass: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Look for Friends"
        
        databaseRef.child(Constants.USERS).queryOrdered(byChild: Constants.NAME).observe(.childAdded, with: { (snapshot) in
            
            self.contactsArray.append(snapshot.value as? NSDictionary)
            
            // Insert the rows
            
            self.userContactsTableView.insertRows(at: [IndexPath(row:self.contactsArray.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredContacts.count
        }
        return self.contactsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

        let user: NSDictionary?
        
        if searchController.isActive && searchController.searchBar.text != "" {
            user = filteredContacts[indexPath.row]
        } else {
            user = self.contactsArray[indexPath.row]
        }
        
        cell.contactName?.text = user?[Constants.NAME] as? String
        cell.contactImage?.image = #imageLiteral(resourceName: "defaultProfileImage.png")
        cell.contactImage?.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }


    
    func updateSearchResults(for searchController: UISearchController) {
        // Update the search results
        filterContent(searchText: self.searchController.searchBar.text!)
    }
    
    func filterContent(searchText:String) {
        self.filteredContacts = self.contactsArray.filter{ user in
            let username = user![Constants.NAME] as? String
            
            return(username?.lowercased().contains(searchText.lowercased()))!
        }
        userContactsTableView.reloadData()
    }

}
