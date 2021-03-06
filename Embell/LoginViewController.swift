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
    
    override func viewDidAppear(_ animated: Bool) {
        checkForCurrentUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForCurrentUser() {
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        if let email=emailTextField.text, let password=passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if user != nil {
                    self.clearTextFields()
                    self.performSegue(withIdentifier: "toHome", sender: self)
                    print(user!.uid)
                }
                else {
                    
                    if let errCode = FIRAuthErrorCode(rawValue: (error as! NSError).code){
                        
                        // TODO: Need to fix errors through UI accordingly
                        switch errCode {
                        case .errorCodeInvalidEmail:
                            print("Invalid email")
                        case .errorCodeWrongPassword:
                            print("Password is wrong")
                        case .errorCodeUserDisabled:
                            print("User account is disabled")
                        case .errorCodeUserNotFound:
                            print("User account cannot be found")
                        default:
                            print("Wrong in some way!!!")
                        }
                    }
                    
                    print(error!)
                    
                }
            })
        }
    }
    
    func clearTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: - Keyboard setup
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
}
















