
//
//  LoginController+Handlers.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/19/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {



    func handleSeletedProfileImageView() {

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true

        presentViewController(picker, animated: true, completion: nil)

    }

    func handleRegister() {

        guard let name = nameTextField.text, let email = emailAddressTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }


        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error)
                return
            }
            //if we reached this point then, we have successfully logged in

            guard let uid = user?.uid else {
                return
            }
            //save user to the database

            //successfully authenticated
            let imageName = NSUUID().UUIDString

            let storageReferance = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")

            guard let profileImage = self.profileImageView.image else {
                return
            }

            guard let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) else {
                return
            }

            storageReferance.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {

                    print(error)
                    return
                }

                if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                    let values = ["name": name, "email": email, "profileImageURL": profileImageURL]

                    self.registerUserIntoDatabase(with: uid, values: values)

                }
            }

        })
    }

    private func registerUserIntoDatabase(with uid: String, values: [String : AnyObject]) {
        let ref = FIRDatabase.database().referenceFromURL("https://firechat-9a8c7.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error)
                return
            }

            let user = User()
            user.setValuesForKeysWithDictionary(values)
            self.messagesController?.setupNavBarWithUser(user)
            
            print("successfully have saved the user to firebase db")
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("canceled")
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        var selectedImage: UIImage?

        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImage = editedImage
        }else if let originalImage = info["UIImagePickerControllerOringalImage"] as? UIImage {
            selectedImage = originalImage
        }
        
        if let selectedImage = selectedImage {
            profileImageView.image = selectedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}