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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let user: NSDictionary?
        
        if searchController.isActive && searchController.searchBar.text != "" {
            user = filteredContacts[indexPath.row]
        } else {
            user = self.contactsArray[indexPath.row]
        }
        
        cell.textLabel?.text = user?[Constants.NAME] as? String
        cell.detailTextLabel?.text = "Something"

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
