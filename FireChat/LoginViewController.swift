//
//  LoginViewController.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/16/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: Views Setup
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true

        return view
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
        textField.secureTextEntry = true

        return textField
    }()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gameofthrones_splash")
        imageView.contentMode = .ScaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSeletedProfileImageView))
        imageView.addGestureRecognizer(tapGesture)
        imageView.userInteractionEnabled = true

        return imageView
    }()

    //MARK: Lazy loading
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161, alpha: 1)
        button.setTitle("Register", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.addTarget(self, action: #selector(handleLoginRegister), forControlEvents: .TouchUpInside)

        return button
    }()

    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Login", "Register"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = UIColor.whiteColor()
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), forControlEvents: .ValueChanged)

        return segmentedControl
    }()

    // MARK: Constraint Varibles
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordFieldHeightAnchor: NSLayoutConstraint?

    var messagesController: MessagesViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151, alpha: 1)

        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)

        //add input fields to container view
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparator)
        inputsContainerView.addSubview(emailAddressTextField)
        inputsContainerView.addSubview(emailSeparator)
        inputsContainerView.addSubview(passwordTextField)


        // add logo/profile image view
        view.addSubview(profileImageView)

        setupInputsContainer()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
    }

    func handleLoginRegisterChange() {
        loginRegisterButton.setTitle(loginRegisterSegmentedControl.titleForSegmentAtIndex(loginRegisterSegmentedControl.selectedSegmentIndex), forState: .Normal)
        // change heigh of input containerView

        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150

        //change the height of nameTextField
        nameTextFieldHeightAnchor?.active = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.active = true

        //Change the height of the email and password fields
        emailTextFieldHeightAnchor?.active = false
        emailTextFieldHeightAnchor = emailAddressTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.active = true

        passwordFieldHeightAnchor?.active = false
        passwordFieldHeightAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordFieldHeightAnchor?.active = true
    }

    func handleLoginRegister() {
        loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? handleLogin() : handleRegister()
    }
    func handleLogin() {
        guard let email = emailAddressTextField.text, let password = passwordTextField.text else {
            print("need to provide input values for email and password")
            return
        }

        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in

            if error != nil {
                print(error)
                return
            }

            //if we reach here, then the user has signed in.
            print("the user has signed in")
            self.dismissViewControllerAnimated(true, completion: nil)

        })

    }

    

    func setupLoginRegisterSegmentedControl() {
        // x value
        loginRegisterSegmentedControl.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        // y value
        loginRegisterSegmentedControl.bottomAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor, constant: -12).active = true

        //width
        loginRegisterSegmentedControl.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true

        // height
        loginRegisterSegmentedControl.heightAnchor.constraintEqualToConstant(30).active = true
    }

    func setupProfileImageView() {

        // x value
        profileImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        // y value
        profileImageView.bottomAnchor.constraintEqualToAnchor(loginRegisterSegmentedControl.topAnchor, constant: -12).active = true

        //width
        profileImageView.widthAnchor.constraintEqualToConstant(150).active = true
        // height
        profileImageView.heightAnchor.constraintEqualToConstant(150).active = true

    }

    func setupLoginRegisterButton() {
        // need x, y, width and height
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 12).active = true

        //width
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        //height
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true
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
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraintEqualToConstant(150)
        inputsContainerViewHeightAnchor?.active = true

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
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.active = true

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

        emailTextFieldHeightAnchor = emailAddressTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.active = true

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
        passwordFieldHeightAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordFieldHeightAnchor?.active = true
    }
    
}
