//
//  ViewController.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/16/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit
import Firebase

class MessagaesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .Plain, target: self, action: #selector(handleLogout))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "new_message_icon"), style: .Plain, target: self, action: #selector(handleNewMessage))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        checkIfUserIsLoggedIn()
    }

    func handleNewMessage() {

        let newMessageController = NewMessageViewController()

        let navigationController = UINavigationController(rootViewController: newMessageController)
        presentViewController(navigationController, animated: true, completion: nil)

    }
    func checkIfUserIsLoggedIn() {
        //user is not logged in
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(#selector(handleLogout), withObject: nil, afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in

                if let dictionary = snapshot.value as? [String: AnyObject] {

                    self.navigationItem.title = dictionary["name"] as? String
                }


            }, withCancelBlock: nil)
        }
    }

    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }

        let loginController = LoginViewController()

        presentViewController(loginController, animated: true, completion: nil)

    }


    // MARK: Status bar

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

