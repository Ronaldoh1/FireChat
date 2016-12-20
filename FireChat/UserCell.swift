//
//  UserCell.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/19/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {



    let profileImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.frame = CGRectMake(64, textLabel!.frame.origin.y - 2, textLabel!.frame.width, textLabel!.frame.height)
        detailTextLabel?.frame = CGRectMake(64, detailTextLabel!.frame.origin.y + 2, detailTextLabel!.frame.width, detailTextLabel!.frame.height)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)

        addSubview(profileImageView)

        //add iOS9 constraints 

        //need x,y, height and width anchor

        profileImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 8).active = true
        profileImageView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(48).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(48).active = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}