//
// NewMessageViewController.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/17/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit
import Firebase

class NewMessageViewController: UITableViewController {

    let cellID = "cellID"
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target:self, action: #selector(handleCancel))

        tableView.registerClass(UserCell.self, forCellReuseIdentifier: cellID)

        fetchUser()
    }

    func fetchUser() {
        FIRDatabase.database().reference().child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) in

            if let dictionary = snapshot.value as? [String : AnyObject] {
                let user = User()
                user.id = snapshot.key
                user.setValuesForKeysWithDictionary(dictionary)
                self.users.append(user)

                //got update the tableView in the main thread.

                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })

            }

            }, withCancelBlock: nil)
    }

    func handleCancel () {
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! UserCell

        let user = users[indexPath.row]
        if let profileImageURL = user.profileImageURL {

            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageURL)

        }
        
        cell.textLabel?.text  = user.name
        cell.detailTextLabel?.text = user.email

        return cell
    }
    
    
    //MARK: TableView Delegate 

    var messagesController: MessagesViewController?
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 72
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dismissViewControllerAnimated(true){

        let user = self.users[indexPath.row]

         self.messagesController?.showChatControllerForUser(user)
        }

    }
    
}
