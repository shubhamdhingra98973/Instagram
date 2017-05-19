//
//  MainVC.swift
//  InstaStory
//
//  Created by Sierra 4 on 09/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import UIKit
import Fusuma
import Sharaku
import AVKit
import AVFoundation
import MobileCoreServices

class MainVC: UIViewController,CapturedPhotoDelegate{
    
    //MARK: Objects
    let rescObj = Resources()
    let fusuma = FusumaViewController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variables
    var arrImagesForStory = [Any]()
    //var instructionView : InstructionView?
    var flag = 0
    var mediaTypes:String?
    var VideoUrl:URL?
    var imgPicker:UIImage?
    var arrAllMedia : String?
    var arrResource : [[String]]?
    var arrImages : [String]?
    var arrName : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fusuma.delegate = self
        arrResource = rescObj.getResources()
        arrImages = arrResource?[0]
        arrName = arrResource?[1]
        
    }
    
    
    //    override func viewWillLayoutSubviews() {
    //       // instructionView = InstructionView.init(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height))
    //
    //    }
    
    
    //MARK: btnAct()
    @IBAction func btnAct(_ sender: UIButton) {
        startSwiftyCamera()
        //instructionView?.displayView(onView:view!)
        
        //        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
        //            let imagePicker = UIImagePickerController()
        //            imagePicker.delegate = self
        //            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
        //            imagePicker.allowsEditing = false
        //            self.present(imagePicker, animated: true, completion: nil)
        //        }
    }
    
    //MARK: startSwiftyCamera()
    func startSwiftyCamera()
    {
        let viewController:CameraVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryBoardIdentifier.CameraVC.rawValue) as! CameraVC
        viewController.delegate = self
        //viewController.instaStoryArray = arrImagesForStory
        self.present(viewController, animated: false, completion: nil)
        
    }
    
    //MARK: startCaptureProcess()
    func startCaptureProcess()
    {
        fusuma.hasVideo = true
        self.present(fusuma,animated: true,completion: nil)
    }
    
    //MARK: btnAction
    func btnAction(sender:UITapGestureRecognizer)
    {
        guard let indicator = sender.view as? InstagramActivityIndicator else { return }
       indicator.startAnimating()
      let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            if sender.view?.tag == 0
            {
                let profileImage = UIImagePickerController()
                profileImage.delegate = self
                profileImage.sourceType = UIImagePickerControllerSourceType.photoLibrary
                profileImage.mediaTypes = [kUTTypeMovie as String,kUTTypeImage as String]
                profileImage.mediaTypes = [MediaTypesPermission.Image.rawValue,MediaTypesPermission.video.rawValue]
                profileImage.allowsEditing = false
                self.present(profileImage , animated: true) {
                }
            }
            if self.arrImagesForStory.count == 0
            {
                Alert.showAlert(title: NoStoryAlertMessage.Title.rawValue,alertText:NoStoryAlertMessage.Text.rawValue,buttonText:NoStoryAlertMessage.ButtonText.rawValue,view:self)
            }
            print(self.arrImagesForStory.count)
            if self.arrImagesForStory.count > 0{
                
                let viewController:StoryVC = UIStoryboard(name: OtherUtility.main.rawValue, bundle: nil).instantiateViewController(withIdentifier:  StoryBoardIdentifier.StoryVC.rawValue) as! StoryVC
                viewController.instaStoryArray = self.arrImagesForStory
                self.present(viewController, animated: false, completion: nil)
                
            }
            indicator.stopAnimating()
            
        }
        //instructionView?.displayView(onView:view!)
    }
    
    //MARK: Delegate func captured image
    func getCapturedImagesAndVideos(sender: Any) {
        arrImagesForStory.append(sender)
    }
    
}

//MARK: Extension :- CollectionView
extension MainVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = arrName?.count
        {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell:MyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.MyCollectionViewCell.rawValue, for: indexPath) as? MyCollectionViewCell else
        {
            return MyCollectionViewCell()
        }
        cell.imgUserProfile.image = UIImage(named:arrImages?[indexPath.row] ?? OtherUtility.Nil.rawValue)
        if indexPath.row == 0
        {
            cell.lblUserName.text = "Your Story"
        }
        else
        {
            cell.lblUserName.text = arrName?[indexPath.row]
            cell.indicatorView.tag = indexPath.item
            
        }
        cell.indicatorView.isUserInteractionEnabled = true
        cell.btnClick.isUserInteractionEnabled = false
        
        cell.imgUserProfile.tag = indexPath.item
        cell.indicatorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainVC.btnAction(sender:))))
        return cell
    }
    func tap( sender:UITapGestureRecognizer)
    {
        guard let indicator = sender.view as? InstagramActivityIndicator else { return }
        indicator.startAnimating()
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("func called")
        if indexPath.row == 0
        {
            let profileImage = UIImagePickerController()
            profileImage.delegate = self
            profileImage.sourceType = UIImagePickerControllerSourceType.photoLibrary
            profileImage.allowsEditing = false
            self.present(profileImage , animated: true) {
            }
            
        }
        
    }
}

