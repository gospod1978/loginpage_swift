//
//  SingUpViewController.swift
//  loginPage
//
//  Created by Mihail Gospodinov on 18/05/2020.
//  Copyright © 2020 Mihail Gospodinov. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase



class SingUpViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var singUp: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0

        Utilities.styleTextField(firstName)
        Utilities.styleTextField(lastName)
        Utilities.styleTextField(email)
        Utilities.styleTextField(password)

        Utilities.styleFilledButton(singUp)
    }
    
    //validate is date is correct, if is ok nil, or error messages
    func validateFields() -> String? {
        //check that all field is fill
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        //check if the password is security check in Hepllpers
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //password isn't securited
            return "Please make your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
    
    // validate the fields
        let error = validateFields()
        
        if error != nil {
            //there somthing wrong, show error message
            showError(error!)
            //self.errorLabel.text = error!
            //self.errorLabel.alpha = 1
            
        }
        else {
            //create the reference whit textfield
            let first_name = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let last_name = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emails = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwords = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create the user
            Auth.auth().createUser(withEmail: emails, password: passwords) { (result, err) in
                if err != nil {
                    //there was an error to create the user
                    self.showError("Error creating user.")
                    //self.errorLabel.text = "Error creating user."
                    //self.errorLabel.alpha = 1
                }
                else {
                    //user was created succssefully
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["first_name":first_name, "last_name":last_name, "uid":result!.user.uid]) { (error) in
                        if error != nil {
                        //show error message
                            //self.errorLabel.text = "User data couldn't save"
                            //self.errorLabel.alpha = 1
                            self.showError("User data couldn't save")
                        }
                    }
                    //transition to homescrin
                    self.transitionToHome()
                }
            }
            
        }
        
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        //self.errorLogin.text = error!.localizedDescription
        //self.errorLogin.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: constante.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
