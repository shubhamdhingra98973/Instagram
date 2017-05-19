/*Copyright (c) 2016, Andrew Walz.
 
 Redistribution and use in source and binary forms, with or without modification,are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 */

import UIKit

class PhotoViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private var backgroundImage: UIImage
    
    init(image: UIImage) {
        self.backgroundImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        let backgroundImageView = UIImageView(frame: view.frame)
        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFit
        backgroundImageView.image = backgroundImage
        view.addSubview(backgroundImageView)
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
