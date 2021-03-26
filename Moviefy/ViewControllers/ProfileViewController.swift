//
//  ProfileViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import UIKit

class ProfileViewController: UIViewController {

    var user = User.shared
     
    @IBOutlet weak var username: UITextView!
    @IBOutlet weak var email: UITextView!
    
    @IBAction func onSignOutButtonTap(_ sender: Any) {
        CoreDataHelper().updateLogIn(username: user.username, isLoggedIn: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = user.username
        email.text = user.email
    }
}
