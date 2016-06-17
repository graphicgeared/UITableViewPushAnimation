//
//  TargetViewController.swift
//  OpenAnimation
//
//  Created by Tapas Pal on 11/06/16.
//  Copyright © 2016 Contrivance. All rights reserved.
//  http://www.contrivanceinfo.com
//

import UIKit

class TargetViewController: UIViewController {
    
    var layerImage: UIImage?
    var cellRect: CGRect = CGRectZero
    
    private var topPart: UIImageView!
    private var bottomPart: UIImageView!
    private var lcTop: NSLayoutConstraint!
    private var lcBottom: NSLayoutConstraint!
    
    
    @IBOutlet weak var imgvBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade
    }
    
    @IBAction func backAction() {
        startAnimation()
    }
}

private extension TargetViewController {
    
    func prepareScreen() {
        prepareScreenForAnimation()
        self.view.layoutIfNeeded()
        startAnimation()
    }
    
    func prepareScreenForAnimation() {
        let takeUpperMargin = cellRect.origin.y > UIScreen.mainScreen().bounds.height / 2
        let width = UIScreen.mainScreen().bounds.width
        let topPartHeight = takeUpperMargin ? cellRect.origin.y : cellRect.origin.y + cellRect.size.height
        let topImage = UIImage.crop(source: layerImage!, frame: CGRectMake(0, 0, width, topPartHeight))
        
        let bottomStartOrigin = takeUpperMargin ? cellRect.origin.y : topPartHeight
        let bottomPartHeight = UIScreen.mainScreen().bounds.height - bottomStartOrigin
        let bottomImage = UIImage.crop(source: layerImage!, frame: CGRectMake(0, bottomStartOrigin, width, bottomPartHeight))
        
        topPart = UIImageView()
        topPart.translatesAutoresizingMaskIntoConstraints = false
        topPart.contentMode = .ScaleAspectFit
        topPart.image = topImage
        view.addSubview(topPart)
        
        let views1 = ["view" : topPart]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views1))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(\(bottomStartOrigin))]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views1))
        lcTop = NSLayoutConstraint(item: topPart, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
        view.addConstraint(lcTop)
        
        
        bottomPart = UIImageView()
        bottomPart.translatesAutoresizingMaskIntoConstraints = false
        bottomPart.contentMode = .ScaleAspectFit
        bottomPart.image = bottomImage
        view.addSubview(bottomPart)
        
        let views2 = ["view" : bottomPart]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views2))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(\(bottomPartHeight))]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views2))
        lcBottom = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: bottomPart, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(lcBottom)
    }
    
    func startAnimation() {
        let isClose = lcTop.constant == 0
        lcTop.constant = isClose ? -topPart.bounds.height : 0
        lcBottom.constant = isClose ? -bottomPart.bounds.height : 0
        
        UIView.animateWithDuration(0.5, animations: {
            self.view.layoutIfNeeded()
            if isClose {
                self.topPart.alpha = 0
                self.bottomPart.alpha = 0
            } else {
                self.topPart.alpha = 1
                self.bottomPart.alpha = 1
            }
            }) { (completed) in
                if !isClose {
                    self.navigationController?.popViewControllerAnimated(false)
                }
        }
    }
}
