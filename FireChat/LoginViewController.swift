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
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        return button
    }()

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let nameSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let emailAddressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let emailSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151, alpha: 1)

        view.addSubview(inputsContainerView)
        view.addSubview(loginButton)

        //add input fields to container view 
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparator)
        inputsContainerView.addSubview(emailAddressTextField)
        inputsContainerView.addSubview(emailSeparator)
        inputsContainerView.addSubview(passwordTextField)


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

        setupInputTextFields()
    }

    func setupInputTextFields() {

        //NAME
        //center the x value
        nameTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true

        // y value
        nameTextField.topAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor).active = true

        //Width
        nameTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true

        // Height
        nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3).active = true

        //NameSeparator 

        //center the x value
        nameSeparator.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true

        // y value
        nameSeparator.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true

        //Width
        nameSeparator.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true

        // Height
        nameSeparator.heightAnchor.constraintEqualToConstant(1).active = true


        //EMAIL
        //center the x value
        emailAddressTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true

        // y value
        emailAddressTextField.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true

        //Width
        emailAddressTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true

        // Height
        emailAddressTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3).active = true

        //NameSeparator

        //center the x value
        emailSeparator.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true

        // y value
        emailSeparator.topAnchor.constraintEqualToAnchor(emailAddressTextField.bottomAnchor).active = true

        //Width
        emailSeparator.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true

        // Height
        emailSeparator.heightAnchor.constraintEqualToConstant(1).active = true

        //PASSWORD

        //center the x value
        passwordTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true

        // y value
        passwordTextField.topAnchor.constraintEqualToAnchor(emailAddressTextField.bottomAnchor).active = true

        //Width
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true

        // Height
        passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3).active = true

    }


}
