//
//  ChatLogController.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/28/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate {

    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()

    var user: User? {
        didSet{
            navigationItem.title  = user?.name
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        setupInputComponents()

        collectionView?.backgroundColor = UIColor.whiteColor()
    }


    // MARK: Helpers

    func setupInputComponents() {
        let containverView = UIView()
        containverView.backgroundColor = UIColor.redColor()
        containverView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(containverView)

        //iOS9 Constraints anchors

        //x,y,w,h
        containverView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        containverView.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        containverView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        containverView.heightAnchor.constraintEqualToConstant(50).active = true


        let sendButton = UIButton(type: .System)
        sendButton.setTitle("Send", forState: .Normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(sendMessage), forControlEvents: .TouchUpInside)

        containverView.addSubview(sendButton)

        //x, y, w , h 
        sendButton.rightAnchor.constraintEqualToAnchor(containverView.rightAnchor).active  = true
        sendButton.centerYAnchor.constraintEqualToAnchor(containverView.centerYAnchor).active = true
        sendButton.widthAnchor.constraintEqualToConstant(80).active = true
        sendButton.heightAnchor.constraintEqualToAnchor(containverView.heightAnchor).active = true


        //input textfield 


        containverView.addSubview(inputTextField)

        //x,y,w,h 

        inputTextField.leftAnchor.constraintEqualToAnchor(containverView.leftAnchor, constant: 8).active = true
        inputTextField.centerYAnchor.constraintEqualToAnchor(containverView.centerYAnchor).active = true
        inputTextField.rightAnchor.constraintEqualToAnchor(sendButton.leftAnchor).active = true
        inputTextField.heightAnchor.constraintEqualToAnchor(containverView.heightAnchor).active = true

        let separtorLine = UIView()
        separtorLine.backgroundColor = UIColor(r: 220, g: 220 , b: 220, alpha: 1)
        separtorLine.translatesAutoresizingMaskIntoConstraints = false
        containverView.addSubview(separtorLine)

        //x,y,w,h

        separtorLine.leftAnchor.constraintEqualToAnchor(containverView.leftAnchor).active = true
        separtorLine.topAnchor.constraintEqualToAnchor(containverView.topAnchor).active = true
        separtorLine.rightAnchor.constraintEqualToAnchor(containverView.rightAnchor).active = true
        separtorLine.heightAnchor.constraintEqualToConstant(1).active = true

    }

    //MARK: Send message to Firebase 

    func sendMessage() {

        let ref = FIRDatabase.database().reference().child("message")
        let childRef = ref.childByAutoId()

        guard let textFieldText = inputTextField.text else {
            return
        }

        guard let toID = user?.id else {
            return
        }

        guard let fromID = FIRAuth.auth()?.currentUser?.uid else {
            return
        }

        let timeStamp: NSNumber = NSDate().timeIntervalSince1970
        let values = ["text" : textFieldText, "toID" : toID, "fromID" : fromID, "timeStamp" : timeStamp]

       // childRef.updateChildValues(values)
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
            }

            let userMessageReference = FIRDatabase.database().reference().child("user-message").child(fromID)
            let messageID = childRef.key
            userMessageReference.updateChildValues([messageID: 1])
        }

    }

    //MARK: UITextFieldDelegate
    func textfieldShouldReturn(textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}

