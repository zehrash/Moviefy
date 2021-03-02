//
//  MainMenuViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 22.02.21.
//

import UIKit

class MainMenuViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        }
    
    // MARK: Variables
    //----------------------------------------------------------------


    
    private lazy var moviesViewController: MoviesViewController = {
      
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewControllerID") as! MoviesViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        return viewController
    }()

    private lazy var watchLaterViewController: WatchLaterViewController = {
       
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "WatchLaterViewControllerID") as! WatchLaterViewController
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    private lazy var watchedViewController: WatchedViewController = {
       
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "WatchedViewControllerID") as! WatchedViewController
        self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var profileViewController: ProfileViewController = {
       
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewControllerID") as! ProfileViewController
        self.add(asChildViewController: viewController)

        return viewController
    }()

    // MARK: Abstract Method
    //----------------------------------------------------------------

    static func viewController() -> MainMenuViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainMenuViewControllerID") as! MainMenuViewController
    }
    //  MARK: Memory Management Methods
    //----------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        updateView()
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(identifier: "SearchMoviesViewControllerID") as? SearchMoviesViewController {
            
            if(!searchBar.text!.isEmpty){
              
                MovieListModel.getMoviesByKeyword(with: searchBar.text!){
                    result in
                    viewController.movies = result
                    self.present(viewController, animated: true)
                }
          ///  self.present(viewController, animated: true)
            }
        }
    }
   
   
    private func add(asChildViewController viewController: UIViewController) {

        addChild(viewController)

        // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func updateView() {
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: watchedViewController)
            remove(asChildViewController: watchLaterViewController)
            remove(asChildViewController: profileViewController)
            add(asChildViewController: moviesViewController)
        }else if(segmentControl.selectedSegmentIndex == 1 ){
            remove(asChildViewController: moviesViewController)
            remove(asChildViewController: watchedViewController)
            remove(asChildViewController: profileViewController)
            add(asChildViewController: watchLaterViewController)
        }
        else if(segmentControl.selectedSegmentIndex == 2 ){
            remove(asChildViewController: moviesViewController)
            remove(asChildViewController: watchLaterViewController)
            remove(asChildViewController: profileViewController)
            add(asChildViewController: watchedViewController)
        }
        else {
            remove(asChildViewController: moviesViewController)
            remove(asChildViewController: watchLaterViewController)
            remove(asChildViewController: watchedViewController)
            add(asChildViewController: profileViewController)
        }
    }

    func setupView() {
        updateView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
