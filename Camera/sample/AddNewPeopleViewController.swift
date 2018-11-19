//
//  AddNewPeopleViewController.swift
//  VidooApp
//
//  Created by tungpt on 11/14/18.
//  Copyright © 2018 eZLO. All rights reserved.
//

import UIKit
import Cartography
fileprivate struct AddNewPeopleViewControllerConstants {
    static let userNameViewRect   :   CGRect         = CGRect.init(x: 8, y: 20, width: 0, height: 60)
    static let userPhotosViewRect   :   CGRect         = CGRect.init(x: 8, y: 0, width: 0, height: 300)
    static let spacing:CGFloat = 16
    static let saveTitle = "Save"
    static let title = "Add New"
}
class AddNewPeopleViewController: BaseViewController {
    //Mark public
    private var imagePicker: UIImagePickerController!
    private var imageType:CreatePeopleImageViewType = .left
    private var userNameView:CreatePeopleUserName!
    private var userPhotosView:CreatePeopleUserPhotos!
    enum ImageSource {
        case photoLibrary
        case camera
    }

    
    static let titleString = AddNewPeopleViewControllerConstants.title
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func initialSetup() {
        title = AddNewPeopleViewController.titleString
        view.backgroundColor = CommonConstants.applicationBackgroundColor
        userNameView = CreatePeopleUserName.init(frame: AddNewPeopleViewControllerConstants.userNameViewRect)
        userNameView.delegate = self
        userPhotosView = CreatePeopleUserPhotos.init(frame: AddNewPeopleViewControllerConstants.userPhotosViewRect)
        userPhotosView.delegate = self
        self.view.addSubview(userNameView)
        self.view.addSubview(userPhotosView)
        
        constrain(userNameView) { (userNameView) in
            userNameView.left == userNameView.superview!.left + AddNewPeopleViewControllerConstants.userNameViewRect.origin.x
            userNameView.right == userNameView.superview!.right - AddNewPeopleViewControllerConstants.userNameViewRect.origin.x
            userNameView.top == userNameView.superview!.top + AddNewPeopleViewControllerConstants.userNameViewRect.origin.y
            userNameView.height == AddNewPeopleViewControllerConstants.userNameViewRect.height
            
        }
        
        constrain(userPhotosView, userNameView) { (userPhotosView, userNameView) in
            userPhotosView.left == userNameView.left
            userPhotosView.right == userNameView.right
            userPhotosView.top == userNameView.bottom + AddNewPeopleViewControllerConstants.spacing
            userPhotosView.bottom == userPhotosView.superview!.bottom
            
        }
        self.addSaveButton()
    }
    
    override func loadViewSetup() {
    }
    
    func addSaveButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: AddNewPeopleViewControllerConstants.saveTitle, style: .done, target: self, action: #selector(savePeople))
    }
    
    @objc func savePeople(){
        print("Save people")
    }
    
    
    func takePhoto() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    func uploadPhoto(){
        print("upload Image")
    }
    
    func showOptions()
    {
  
        let actionSheetController: UIAlertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        let takePhoto: UIAlertAction = UIAlertAction(title: "Take Photo", style: .default) { action -> Void in
            self.takePhoto()
        }
        let otherOption: UIAlertAction = UIAlertAction(title: "Upload Photo", style: .default) { action -> Void in
            self.uploadPhoto()
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(takePhoto)
        actionSheetController.addAction(otherOption)
        self.present(actionSheetController, animated: true, completion: nil)
    }

}
extension AddNewPeopleViewController: CreatePeopleUserPhotosDelegate{
    func didSelectLeftSideButton() {
        imageType = .left
        self.showOptions()
        print("didSelectLeftSideButton")
    }
    func didSelectFullFaceButton() {
        imageType = .center
        self.showOptions()
        print("didSelectFullFaceButton")
    }
    func didSelectRightSideButton() {
        imageType = .right
        self.showOptions()
        print("didSelectRightSideButton")
    }
}
extension AddNewPeopleViewController: CreatePeopleUserNameDelegate{
    func didChangeUserName(userName: String){
        print("didChangeUserName")
    }
}

extension AddNewPeopleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
        self.userPhotosView.setImage(image: selectedImage, type: self.imageType)
    }
}
