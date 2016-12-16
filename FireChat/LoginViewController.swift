//
//  LoginViewController.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/16/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161, alpha: 1)
        button.setTitle("Register", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151, alpha: 1)

        view.addSubview(inputsContainerView)
        view.addSubview(loginButton)

        setupInputsContainer()
        setupLoginRegisterButton()
    }

    func setupLoginRegisterButton() {

        // need x, y, width and height
        loginButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginButton.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 12).active = true
        //width 
        loginButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        //height
        loginButton.heightAnchor.constraintEqualToConstant(50).active = true
    }

    func setupInputsContainer() {
        // need x, y, width and height contraint

        //center the x value
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true

        //center y value
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true

        //Width
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true

        // Height
        inputsContainerView.heightAnchor.constraintEqualToConstant(150).active = true
    }


}
