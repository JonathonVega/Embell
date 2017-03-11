//
//  LoginViewController.swift
//  Embell
//
//  Created by Jonathon F Vega on 3/9/17.
//  Copyright © 2017 Jonathon Vega. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        if let email=emailTextField.text, let password=passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let u = user {
                    self.performSegue(withIdentifier: "toHome", sender: self)
                }
                else {
                    print("User should be nil!!!")
                    print("This is mahnoor")
                    print("This is an error")
                    print(error!)
                    // Check error message
                }
            })
        }
    }
    
    
    
    
}
