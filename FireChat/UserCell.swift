//
//  UserCell.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/19/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit
import Firebase

class UserCell: UITableViewCell {

    var message: Message? {
        didSet{
            if let toID = message?.toID {
                let ref = FIRDatabase.database().reference().child("users").child(toID)
                ref.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                    if let dictionary = snapshot.value as? [String : AnyObject] {
                        self.textLabel?.text = dictionary["name"] as? String

                        if let profileImageURL = dictionary["profileImageURL"] as? String {
                            self.profileImageView.loadImageUsingCacheWithUrlString(profileImageURL)

                        }
                    }
                })
            }
            
            self.detailTextLabel?.text = message?.text
            if let seconds = message?.timeStamp?.doubleValue {
                let date = NSDate(timeIntervalSince1970: seconds)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.stringFromDate(date)
            }


        }
    }


    let profileImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        
        return imageView
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "HH:MM"
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.darkGrayColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.frame = CGRectMake(64, textLabel!.frame.origin.y - 2, textLabel!.frame.width, textLabel!.frame.height)
        detailTextLabel?.frame = CGRectMake(64, detailTextLabel!.frame.origin.y + 2, detailTextLabel!.frame.width, detailTextLabel!.frame.height)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)

        addSubview(profileImageView)
        addSubview(timeLabel)

        //add iOS9 constraints 

        //need x,y, height and width anchor

        profileImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 8).active = true
        profileImageView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(48).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(48).active = true

        //need x,y, height and width

        timeLabel.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -8).active = true
        timeLabel.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 18).active = true
        timeLabel.widthAnchor.constraintEqualToConstant(100)
        timeLabel.heightAnchor.constraintEqualToAnchor(textLabel?.heightAnchor).active = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}