//
//  StoryVC.swift
//  InstaStory
//
//  Created by Sierra 4 on 12/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class StoryVC: UIViewController {
    
    //MARK: Variables
    var spb: SegmentedProgressBar!
    var instaStoryArray = [Any]()
    var player:AVPlayerLayer?
    
    //MARK: IBOultets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    //MARK: viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        setUpSegmentedBar()
    }
    
    
    
}
