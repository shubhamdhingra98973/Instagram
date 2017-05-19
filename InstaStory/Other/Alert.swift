//
//  Alert.swift
//  InstaStory
//
//  Created by Sierra 4 on 13/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import Foundation
import JSSAlertView

class Alert{
    
    //MARK: showAlert
    class func showAlert(title:String,alertText:String,buttonText:String,view:UIViewController)
    {
        let alertview = JSSAlertView().show(
            view,
            title: title,
            text: alertText,
            buttonText: buttonText,
            color: UIColorFromHex(0x9b59b6, alpha: 1)
        )
        
        alertview.setTitleFont(Font.TitleFont.rawValue)
        alertview.setTextFont(Font.TextFont.rawValue)
        alertview.setButtonFont(Font.ButtonFont.rawValue)
        alertview.setTextTheme(.light)
    }
}
