//
//  SignUpViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 23.03.21.
//

import UIKit

class SignUpViewController: UIViewController {
    let helper = CoreDataHelper()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func onStartButtonTap(_ sender: Any) {

        if username.text != nil && email.text != nil && password.text != nil{
            helper.addUser(username: username.text!, email: email.text!, password: password.text!, logged: true)
            
            if let viewController = storyboard?.instantiateViewController(identifier: "MainMenuViewControllerID") as? MainMenuViewController {
                    self.present(viewController, animated: true)
                }
        }else {
            //Alert -> all fields must be filled
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
