//
//  SimpleFeatures.swift
//  MediaSocial
//
//  Created by NguyenVanTu on 8/10/17.
//  Copyright © 2017 Nguyen Van Tu. All rights reserved.
//

import UIKit

class SimpleFeatures: NSObject {
    class func saveImageToCameraRoll(image: UIImage)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    class func writeImageToDirectory(image: UIImage, name: String)
    {
        let destinationPath = documentsPath?.appending("/\(name)")
        if !NVT_FileManager.checkCreateFolders(path: destinationPath!) {
            try! UIImageJPEGRepresentation(image,1.0)?.write(to: URL.init(fileURLWithPath: destinationPath!))
        }
    }
    class func shareViaActivity(object: [Any], view: UIView) -> UIActivityViewController
    {
        let activityViewController = UIActivityViewController(activityItems: object, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view // so that iPads won't crash
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        return activityViewController
    }
}
