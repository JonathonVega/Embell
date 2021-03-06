//
//  RegisterViewController.swift
//  Embell
//
//  Created by Jonathon F Vega on 3/10/17.
//  Copyright © 2017 Jonathon Vega. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerAccountButtonTapped(_ sender: UIButton) {
        if let email=emailTextField.text, let password=passwordTextField.text, let name=nameTextField.text  {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if user != nil {
                    
                    
                    DBProvider.Instance.saveUser(withID: user!.uid, email: email, password: password, name: name)
                    
                    
                    self.dismiss(animated: true, completion: nil)
                    self.performSegue(withIdentifier: "toHome", sender: self)
                    
                } else {
                    
                    if let errCode = FIRAuthErrorCode(rawValue: (error as! NSError).code){
                        
                        // TODO: Need to fix errors through UI accordingly
                        switch errCode {
                        case .errorCodeInvalidEmail:
                            print("Invalid email")
                        case .errorCodeEmailAlreadyInUse:
                            print("Email already in use")
                        default:
                            print("Wrong in some way!!!")
                        }
                    }
                    
                    print(error!)
                    
                }
            })
        }
    }
    
    
    /*func saveUserInfoToFirebase() {
        if checkFirstNameField() && checkLastNameField() {
            let firstName = self.firstName.text, lastName = self.lastName.text
            if FIRAuth.auth()?.currentUser != nil {
                
            }
            DBProvider.Instance.saveUser(withID: user!.uid, firstName: firstName, lastName: lastName)
        }
    }
    
    func checkFirstNameField() -> Bool{
        return (firstName.text != nil)
    }
    
    func checkLastNameField() -> Bool {
        return (lastName.text != nil)
    }*/
    
    
    
    
    
    
    @IBAction func backToSignInViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Mark: - Keyboard setup
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}














