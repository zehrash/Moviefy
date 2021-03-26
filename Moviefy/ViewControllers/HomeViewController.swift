//
//  HomeViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 24.03.21.
//swiftlint: disable opening_brace

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    override func viewDidLoad() {
       super.viewDidLoad()
        logoImage.image = UIImage(named: "logo")
    }
    override func viewDidAppear(_ animated: Bool) {
        getLoggedInUser()
    }
    func getLoggedInUser(){
        if CoreDataHelper().getLoggedInUser() != nil {
        if let viewController = storyboard?.instantiateViewController(identifier: "MainMenuViewControllerID")
            as? MainMenuViewController {
                self.present(viewController, animated: true)
            }
        }else {
         if let viewController = storyboard?.instantiateViewController(identifier: "MainViewControllerID")
                as? MainViewController {
                self.present(viewController, animated: true)
            }
        }
    }
}
