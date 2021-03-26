//
//  LoginViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import UIKit

class LoginViewController: UIViewController {
    let helper = CoreDataHelper()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func onStartButtonTap(_ sender: Any) {
        let isLoggedIn = helper.isUserLoggedIn(username: username.text!)
        if(username.text != nil && password.text != nil){
            if(!isLoggedIn){
                helper.updateLogIn(username:username.text!, isLoggedIn: true)
                User.shared.setUser(username: username.text!, email: "", password: password.text!) //change isUserLoggedIn to getLoggedInUser and return the user or nil
            }
        
            if let viewController = storyboard?.instantiateViewController(identifier: "MainMenuViewControllerID") as? MainMenuViewController {
                self.present(viewController, animated: true)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
