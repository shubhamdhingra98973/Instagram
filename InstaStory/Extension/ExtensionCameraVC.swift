//
//  ExtensionCameraVC.swift
//  InstaStory
//
//  Created by Sierra 4 on 12/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import Foundation
import UIKit
import SwiftyCam
import JSSAlertView

extension CameraVC
{
    //MARK:- Delegate Methods
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        showAlert(resource: photo)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection)
    {
        captureButton.growButton()
        UIView.animate(withDuration: 0.25, animations: {
            self.flashButton.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection)
    {
        captureButton.shrinkButton()
        UIView.animate(withDuration: 0.25, animations: {
            self.flashButton.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL)
    {
        showAlert(resource: url)
        let newVC = VideoViewController(videoURL: url)
        self.present(newVC, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint)
    {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                focusView.removeFromSuperview()
            })
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print(zoom)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print(camera)
    }
    @objc private func cameraSwitchAction(_ sender: Any) {
        switchCamera()
    }
    
    @objc private func toggleFlashAction(_ sender: Any) {
        flashEnabled = !flashEnabled
        
        if flashEnabled == true {
            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
        }
    }
    
    //MARK:- showAlert()
    func showAlert(resource:Any)
    {
        let alertview = JSSAlertView().show(
            self,
            title: AlertMessage.Title.rawValue,
            text: AlertMessage.Text.rawValue,
            buttonText: AlertMessage.ButtonText.rawValue,
            cancelButtonText:AlertMessage.CancelButtonText.rawValue  ,
            color: UIColorFromHex(0x9b59b6, alpha: 1)
            // This tells JSSAlertView to create a two-button alert
        )
        alertview.addAction {
            if let delegate = self.delegate ?? nil
            {
                delegate.getCapturedImagesAndVideos(sender:resource)
                self.dismiss(animated: false, completion: nil)
            }
        }
        alertview.addCancelAction {
        }
        alertview.setTitleFont(Font.TitleFont.rawValue) // Title font
        alertview.setTextFont(Font.TextFont.rawValue) // Alert body text font
        alertview.setButtonFont(Font.ButtonFont.rawValue) // Button text font
        alertview.setTextTheme(.light)
    }
    
    //MARK:- addButtons()
     func addButtons() {
        captureButton = SwiftyRecordButton(frame: CGRect(x: view.frame.midX - 37.5, y: view.frame.height - 100.0, width: 75.0, height: 75.0))
        self.view.addSubview(captureButton)
        captureButton.delegate = self
        flipCameraButton = UIButton(frame: CGRect(x: (((view.frame.width / 2 - 37.5) / 2) - 15.0), y: view.frame.height - 74.0, width: 30.0, height: 23.0))
        flipCameraButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: UIControlState())
        flipCameraButton.addTarget(self, action: #selector(cameraSwitchAction(_:)), for: .touchUpInside)
        self.view.addSubview(flipCameraButton)
        
        let test = CGFloat((view.frame.width - (view.frame.width / 2 + 37.5)) + ((view.frame.width / 2) - 37.5) - 9.0)
        
        flashButton = UIButton(frame: CGRect(x: test, y: view.frame.height - 77.5, width: 18.0, height: 30.0))
        flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
        flashButton.addTarget(self, action: #selector(toggleFlashAction(_:)), for: .touchUpInside)
        self.view.addSubview(flashButton)
      
    }
    
    //MARK:- startCamera()
    func startCamera()
    {
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        addButtons()
    }


}
