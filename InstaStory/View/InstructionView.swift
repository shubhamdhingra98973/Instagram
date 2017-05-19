//
//  InstructionView.swift
//  InstaStory
//
//  Created by Sierra 4 on 15/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import UIKit

class InstructionView: UIView{

    var view:UIView?
    var cameraObj = CameraVC()
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    func loadViewFromXibFile() -> UIView
    {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "InstructionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView(frame:frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(frame: CGRect)
    {
        view = loadViewFromXibFile()
        view?.frame = frame
        view?.frame = bounds
        addSubview(view!)
        // Adds a shadow to our view
        self.view?.layer.cornerRadius = 4.0
        self.view?.layer.shadowColor = UIColor.red.cgColor
        self.view?.layer.shadowOpacity = 0.2
        self.view?.layer.shadowRadius = 4.0
        self.view?.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        visualEffectView?.layer.cornerRadius = 4.0
        
    }
    func displayView(onView:UIView)
    {
        self.alpha = 0.0
        onView.addSubview(self)
        //self.lblTitle?.text = "yes I am"
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.alpha = 1.0
            self.transform = CGAffineTransform.identity
        }) { (finished) -> Void in
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.hideView()
            }
        }
    }
    
    private func hideView()
    {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (finished) -> Void in
           self.removeFromSuperview()
            
        }
//        cameraDelegate = self
//        maximumVideoDuration = 10.0
//        shouldUseDeviceOrientation = true
//        self.addButtons()
    }
    


}
