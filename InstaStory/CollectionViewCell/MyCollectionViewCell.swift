//
//  MyCollectionViewCell.swift
//  InstaStory
//
//  Created by Sierra 4 on 09/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var btnClick: UIButton!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var indicatorView: InstagramActivityIndicator!
    
    //MARK: awakeFromNib()
    override func awakeFromNib() {
        imgUserProfile.layer.borderColor = UIColor.white.cgColor
        imgUserProfile.layer.borderWidth = 1
        imgUserProfile.layer.masksToBounds = true
    }
}
