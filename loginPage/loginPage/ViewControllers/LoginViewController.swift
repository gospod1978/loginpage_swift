//
//  LoginViewController.swift
//  loginPage
//
//  Created by Mihail Gospodinov on 18/05/2020.
//  Copyright © 2020 Mihail Gospodinov. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLogin: UITextField!
    
    @IBOutlet weak var passwordLogIn: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var errorLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
           errorLogin.alpha = 0
           
           Utilities.styleTextField(emailLogin)
           Utilities.styleTextField(passwordLogIn)
           
           Utilities.styleFilledButton(login)
       }
    

    @IBAction func loginTapped(_ sender: Any) {
        // validate the textfield trqbva da napravq validaciqta ot SingUp
        
        // create instance
        let emails = emailLogin.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwords = passwordLogIn.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //sign in the users
        Auth.auth().signIn(withEmail: emails, password: passwords) { (result, error) in
            if error != nil {
                self.errorLogin.text = error!.localizedDescription
                self.errorLogin.alpha = 1
            }
            else {
                let homeViewController = self.storyboard?.instantiateViewController(identifier: constante.Storyboard.homeViewController) as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
            
        }
    }
    

}
