//
//  PhotoManager.swift
//  PhotoManager
//
//  Created by Nguyen Van Tu on 10/25/17.
//  Copyright © 2017 ANPSOFT. All rights reserved.
//
//pod "QBImagePickerController"
//#import <QBImagePickerController/QBImagePickerController.h>
//<key>NSCameraUsageDescription</key>    <string>Ứng dụng muốn truy cập camera của bạn</string>
//<key>NSPhotoLibraryUsageDescription</key>    <string>Ứng dụng muốn truy cập thư việc ảnh</string>
import UIKit
import QBImagePickerController
protocol PhotoManagerDelegate
{
    func didSelectImage(image: [UIImage])
    func presentVC() -> UIViewController
}
class PhotoManager: NSObject {
    var delegate:PhotoManagerDelegate?
    var imageLibraryPickerController:QBImagePickerController!
    lazy var imageTakePictureController:UIImagePickerController? = {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imageTakePictureController = UIImagePickerController()
            imageTakePictureController.allowsEditing = true
            imageTakePictureController.sourceType = .camera
            imageTakePictureController.delegate = self
            return imageTakePictureController
        }
        return nil
        
    }()
    func setupImagePicker()
    {
        imageLibraryPickerController = QBImagePickerController()
        imageLibraryPickerController.allowsMultipleSelection = true
        imageLibraryPickerController.showsNumberOfSelectedAssets = false
        imageLibraryPickerController.mediaType = .image
        imageLibraryPickerController.delegate = self
        imageLibraryPickerController.maximumNumberOfSelection = 5
    }
    func showOptions()
    {
        self.setupImagePicker()
        let actionSheetController: UIAlertController = UIAlertController(title: "Chọn ảnh", message: nil, preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Bỏ qua", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        let takePhoto: UIAlertAction = UIAlertAction(title: "Chụp ảnh", style: .default) { action -> Void in
            self.delegate?.presentVC().present(self.imageTakePictureController!, animated: true, completion: nil)
        }
        let selecFromLib: UIAlertAction = UIAlertAction(title: "Lấy ảnh từ thư viện", style: .default) { action -> Void in
            self.delegate?.presentVC().present(self.imageLibraryPickerController, animated: true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)
        if((self.imageTakePictureController) != nil)
        {
           actionSheetController.addAction(takePhoto)
        }
        actionSheetController.addAction(selecFromLib)
        self.delegate?.presentVC().present(actionSheetController, animated: true, completion: nil)
    }
    
}

extension PhotoManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.delegate?.didSelectImage(image: [image])
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension PhotoManager: QBImagePickerControllerDelegate
{
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        var images = [UIImage]()
        let count = assets.count
        for index in 0 ..< count {
            if let asset = assets[index] as? PHAsset
            {
                let manager = PHImageManager.default()
                manager.requestImageData(for: asset, options: nil, resultHandler: { (imageData, dataUTI, orientation, info) in
                    images.append(UIImage.init(data: imageData!)!)
                    if(index == count - 1)
                    {
                        self.delegate?.didSelectImage(image: images)
                        imagePickerController.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
