//
//  CameraVC.swift
//  InstaStory
//
//  Created by Sierra 4 on 12/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import UIKit
import SwiftyCam
import JSSAlertView

//MARK: CapturedPhotoDelegate
protocol  CapturedPhotoDelegate {
    func getCapturedImagesAndVideos(sender:Any)
}


//MARK: CameraVC
class CameraVC: SwiftyCamViewController,SwiftyCamViewControllerDelegate{
    
    //MARK:- Variables
    var instructionView : InstructionView?
    var flipCameraButton: UIButton!
    var flashButton: UIButton!
    var delegate : CapturedPhotoDelegate? = nil
    var captureButton: SwiftyRecordButton!
    var imagesCaptured = [Any]()
    
    override func viewWillLayoutSubviews()
    {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        self.addButtons()
        instructionView = InstructionView.init(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "overlay") as? [String] ==  nil
        {
            instructionView?.displayView(onView:view!)
            UserDefaults.standard.set("yes", forKey: "overlay")
            
        }
        else
        {
            print("there is something wrong !!")
        }
    }
    
    
}
