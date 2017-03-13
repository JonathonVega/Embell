//
//  UserProfileViewController.swift
//  Embell
//
//  Created by Jonathon F Vega on 3/12/17.
//  Copyright © 2017 Jonathon Vega. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserProfileViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()

        // Do any additional setup after loading the view.
        loadUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        
        if FIRAuth.auth()?.currentUser != nil {
            print((FIRAuth.auth()?.currentUser?.email)!)
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
                dismiss(animated: true, completion: nil)
            } catch let signOutError as NSError{
                print("Error signing out: %@", signOutError)
            }
        }
        
    }
    
    func loadUserInfo() {
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child(Constants.USERS).child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            print(value!)
            let name = value?[Constants.NAME] as? String ?? ""
            print(name)
            self.nameLabel.text = name
            let email = value?[Constants.EMAIL] as? String ?? ""
            print(email)
            self.emailLabel.text = email
        })
        
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
