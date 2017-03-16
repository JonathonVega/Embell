//
//  ContactProfileViewController.swift
//  Embell
//
//  Created by Jonathon F Vega on 3/14/17.
//  Copyright © 2017 Jonathon Vega. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ContactProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var userID: String = ""
    
    var ref: FIRDatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = userID
        
        let ref = FIRDatabase.database().reference()

        // Do any additional setup after loading the view.
        
        
        /*ref.child(Constants.USERS).child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            //print(value!)
            let name = value?[Constants.NAME] as? String ?? ""
            //print(name)
            self.nameLabel.text = name
            let email = value?[Constants.EMAIL] as? String ?? ""
            //print(email)
            self.emailLabel.text = email
        })*/
        
        ref.child(Constants.USERS).child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?[Constants.NAME] as? String
            self.nameLabel.text = name
        }) { (error) in
            print(error.localizedDescription)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
