//
//  Extensions.swift
//  FireChat
//
//  Created by Ronald Hernandez on 12/20/16.
//  Copyright © 2016 TravelFit. All rights reserved.
//

import UIKit

let imageCache = NSCache()

extension UIImageView {

    func loadImageUsingCacheWithUrlString(urlString: String) {
        if let url = NSURL(string: urlString) {

            self.image = nil // this eliminaetes the flashing between images. 
            
            //check cache for image first, if we have found the image in the cache, then we want to return out.

            if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
                self.image = cachedImage
                return
            }


            // otherwise fire off a new download 
            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in

                //download hit an error - lets return out
                if error != nil {
                    print(error)
                    return
                }

                if let downloadedImage = UIImage(data: data!) {
                    dispatch_async(dispatch_get_main_queue(), {
                        imageCache.setObject(downloadedImage, forKey: urlString)
                        self.image = downloadedImage
                    })
                }

            }).resume()
        }
    }
}
