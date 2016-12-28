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
            fetchUserAndSetUpNavigationBar()
        }
    }

    func fetchUserAndSetUpNavigationBar() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }

        FIRDatabase.database().reference().child("users").child(uid).observeSingleEventOfType(.Value, withBlock: { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {

                self.navigationItem.title = dictionary["name"] as? String
                let user = User()
                user.setValuesForKeysWithDictionary(dictionary)
                self.setupNavBarWithUser(user)
            }

            }, withCancelBlock: nil)
    }

    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }

        let loginController = LoginViewController()
        loginController.messagesController = self

        presentViewController(loginController, animated: true, completion: nil)

    }

    func setupNavBarWithUser(user: User) {
        self.navigationItem.title = user.name

        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)

        let containerView = UIView()
        titleView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .ScaleToFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true

        if let profileImageUrl = user.profileImageURL {
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }

        containerView.addSubview(profileImageView)

        //set iOS9 Constraints
        profileImageView.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor).active = true
        profileImageView.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(40).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(40).active = true

        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        //Set iOS9 constraints

        containerView.addSubview(nameLabel)

        nameLabel.leftAnchor.constraintEqualToAnchor(profileImageView.rightAnchor, constant: 8).active = true
        nameLabel.centerYAnchor.constraintEqualToAnchor(profileImageView.centerYAnchor).active = true
        nameLabel.rightAnchor.constraintEqualToAnchor(containerView.rightAnchor).active = true
        nameLabel.heightAnchor.constraintEqualToAnchor(profileImageView.heightAnchor).active = true

        containerView.centerXAnchor.constraintEqualToAnchor(titleView.centerXAnchor).active = true
        containerView.centerYAnchor.constraintEqualToAnchor(titleView.centerYAnchor).active = true

        self.navigationItem.titleView = titleView
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showChatController))
        titleView.addGestureRecognizer(gesture)
    }
    
    // MARK: Status bar
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    // MARK: Helper 

    func showChatController() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let chatLogController = ChatLogController(collectionViewLayout: collectionViewLayout)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
}

