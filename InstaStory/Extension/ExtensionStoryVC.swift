//
//  ExtensionStoryVC.swift
//  InstaStory
//
//  Created by Sierra 4 on 12/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation
//MARK:- CollectionViewDelegate (StoryVC)
extension StoryVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instaStoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell:StoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.StoryCollectionViewCell.rawValue, for: indexPath) as? StoryCollectionViewCell else
        {
            return StoryCollectionViewCell()
        }

        if let data = instaStoryArray[indexPath.item] as? UIImage{
            cell.imgShowStoryImage.image = data
            cell.viewVideoStory.isHidden = true
        }
        else{
            cell.imgShowStoryImage.isHidden = true
            let playerL = AVPlayer(url: instaStoryArray[indexPath.row] as! URL)
            player = AVPlayerLayer(player: playerL)
            player?.frame = cell.viewVideoStory.bounds
            cell.viewVideoStory.layer.addSublayer(player!)
            playerL.play()
        }
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.frame.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        print(visibleIndexPath)
        spb.skip()
    }
}


//MARK:- Extension :- SegmentedProgresBar
extension StoryVC : SegmentedProgressBarDelegate {
    
    func segmentedProgressBarChangedIndex(index: Int)
    {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.right, animated: true)
       
    }
    
    func segmentedProgressBarFinished()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setUpSegmentedBar()
    {
        spb = SegmentedProgressBar(numberOfSegments: instaStoryArray.count, duration: 5)
        spb.frame = CGRect(x: 2, y: 30, width: view.frame.width - 10, height: 2)
        spb.delegate = self
        spb.topColor = UIColor.white
        spb.bottomColor = UIColor.white.withAlphaComponent(0.25)
        spb.padding = 2
        view.addSubview(spb)
        spb.startAnimation()
    }
}

