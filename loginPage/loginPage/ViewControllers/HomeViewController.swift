//
//  HomeViewController.swift
//  loginPage
//
//  Created by Mihail Gospodinov on 18/05/2020.
//  Copyright © 2020 Mihail Gospodinov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var singOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(singOut)
    }
    
    @IBAction func singOutToFirst(_ sender: Any) {
        let startViewController = self.storyboard?.instantiateViewController(identifier: constante.Storyboard.startViewController) as? ViewController
        self.view.window?.rootViewController = startViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    

}
