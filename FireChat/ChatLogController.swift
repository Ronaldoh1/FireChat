//
//  ChatLogController.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/28/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Chat Log"
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

        containverView.addSubview(sendButton)

        //x, y, w , h 
        sendButton.rightAnchor.constraintEqualToAnchor(containverView.rightAnchor).active  = true
        sendButton.centerYAnchor.constraintEqualToAnchor(containverView.centerYAnchor).active = true
        sendButton.widthAnchor.constraintEqualToConstant(80).active = true
        sendButton.heightAnchor.constraintEqualToAnchor(containverView.heightAnchor).active = true


        //input textfield 

        let inputTextField = UITextField()
        inputTextField.placeholder = "Enter Message"
        inputTextField.translatesAutoresizingMaskIntoConstraints = false

        containverView.addSubview(inputTextField)

        //x,y,w,h 

        inputTextField.leftAnchor.constraintEqualToAnchor(containverView.leftAnchor, constant: 8).active = true
        inputTextField.centerYAnchor.constraintEqualToAnchor(containverView.centerYAnchor).active = true
        inputTextField.rightAnchor.constraintEqualToAnchor(sendButton.leftAnchor).active = true
        inputTextField.heightAnchor.constraintEqualToAnchor(containverView.heightAnchor).active = true
    }

}
