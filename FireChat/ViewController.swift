//
//  ViewController.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/16/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .Plain, target: self, action: #selector(handleLogout))

        
    }

    func handleLogout() {
        let loginController = LoginViewController()

        presentViewController(loginController, animated: true, completion: nil)

    }


    // MARK: Status bar 

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

