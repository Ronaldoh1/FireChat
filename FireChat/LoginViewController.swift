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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151, alpha: 1)

        view.addSubview(inputsContainerView)

        setupInputsContainer()
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
