//
//  MainViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 23.03.21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.image = UIImage(named: "logo")
    }
    
    @IBAction func onSignUpButtonTap(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(identifier: "SignUpViewControllerID") as? SignUpViewController {
            self.present(viewController, animated: true)
        }
        
    }
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(identifier: "LoginViewControllerID") as? LoginViewController {
            self.present(viewController, animated: true)
        }
    }
}
