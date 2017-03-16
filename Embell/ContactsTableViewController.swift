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
    
    var contactsArray = [Profile]()
    var filteredContacts = [Profile]()
    
    var databaseRef = FIRDatabase.database().reference()
    
    
    var userIDToPass:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        addContactsFromFirebaseToContactsArray()
        
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

        let user: Profile?
        
        if searchController.isActive && searchController.searchBar.text != "" {
            user = filteredContacts[indexPath.row]
        } else {
            user = self.contactsArray[indexPath.row]
        }
        
        cell.contactName?.text = user?.name
        cell.contactImage?.image = #imageLiteral(resourceName: "defaultProfileImage.png")
        cell.userID = (user?.userID)!
 
        return cell
    }
    
    
    
    
    
    
    
    
    
    // MARK: - Selecting a cell
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! ContactTableViewCell
        
        userIDToPass = currentCell.userID
        performSegue(withIdentifier: "seeContactProfileSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "seeContactProfileSegue") {
            let viewController = segue.destination as! ContactProfileViewController
            viewController.userID = userIDToPass
        }
    }
    
    
    
    
    
    
    
    
    // MARK: - Setup Profile from Firebase
    
    func addContactsFromFirebaseToContactsArray(){
        databaseRef.child(Constants.USERS).queryOrdered(byChild: Constants.NAME).observe(.childAdded, with: { (snapshot) in
            
            let contactInfo = snapshot.value as? NSDictionary
            let contactName = (contactInfo?[Constants.NAME] as? String)!
            let contactEmail = (contactInfo?[Constants.EMAIL] as? String)!
            
            
            let contactProfile: Profile = Profile(userID: snapshot.key, name: contactName, email: contactEmail)
            
            self.contactsArray.append(contactProfile)
            
            // Insert the rows
            
            self.userContactsTableView.insertRows(at: [IndexPath(row:self.contactsArray.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
    
    // MARK: - Search Bar Setup

    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Look for Friends"
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Update the search results
        filterContent(searchText: self.searchController.searchBar.text!)
    }
    
    func filterContent(searchText:String) {
        self.filteredContacts = self.contactsArray.filter{ user in
            let username = user.name
            
            return(username.lowercased().contains(searchText.lowercased()))
        }
        userContactsTableView.reloadData()
    }

}
