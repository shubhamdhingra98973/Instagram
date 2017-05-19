//
//  ExtensionMainVC.swift
//  InstaStory
//
//  Created by Sierra 4 on 12/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import Fusuma
import Sharaku
import MobileCoreServices

//MARK:- Extension UIImagePickerController (MainVC).
extension MainVC:  UIImagePickerControllerDelegate ,UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker : UIImagePickerController , didFinishPickingMediaWithInfo info : [String : Any]) {
        mediaTypes = (info[UIImagePickerControllerMediaType] as! String)
        // mediatype ImagePicker.
        if mediaTypes == kUTTypeImage as String
        {
            imgPicker = (info[UIImagePickerControllerOriginalImage] as! UIImage)
            arrImagesForStory.append(imgPicker as Any)
            picker.dismiss(animated: true, completion: nil)
            let vc = SHViewController(image: imgPicker!)
            vc.delegate = self
            self.present(vc, animated:true, completion: nil)
        }
        //mediatype VideoPicker.
        if mediaTypes == kUTTypeVideo as String || mediaTypes == kUTTypeMovie as String
        {
            VideoUrl = (info[UIImagePickerControllerMediaURL] as! URL)
            arrImagesForStory.append(VideoUrl as Any)
            picker.dismiss(animated: true, completion: nil)
        }
  }
}

//MARK:- Extension Fusuma Delegate (MainVC).
extension MainVC:FusumaDelegate{
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        arrImagesForStory.append(image)
    }
    
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        
        let vc = SHViewController(image: image)
        vc.delegate = self
        self.present(vc, animated:true, completion: nil)
    }
    
    func fusumaCameraRollUnauthorized() {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        arrImagesForStory.append(fileURL)
    }
}

//MARK:-7 Extension SHViewControllerDelegate (MainVC).
extension MainVC: SHViewControllerDelegate {
    func shViewControllerImageDidFilter(image: UIImage) {
        // Filtered image will be returned here.
        arrImagesForStory.removeLast()
        arrImagesForStory.append(image)
    }
    func shViewControllerDidCancel() {
    }
}



