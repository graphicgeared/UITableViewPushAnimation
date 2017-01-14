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
    var cellRect: CGRect = CGRect.zero
    
    fileprivate var topPart: UIImageView!
    fileprivate var bottomPart: UIImageView!
    fileprivate var lcTop: NSLayoutConstraint!
    fileprivate var lcBottom: NSLayoutConstraint!
    
    
    @IBOutlet weak var imgvBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .fade
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
        let takeUpperMargin = cellRect.origin.y > UIScreen.main.bounds.height / 2
        let width = UIScreen.main.bounds.width
        let topPartHeight = takeUpperMargin ? cellRect.origin.y : cellRect.origin.y + cellRect.size.height
        let topImage = UIImage.crop(source: layerImage!, frame: CGRect(x: 0, y: 0, width: width, height: topPartHeight))
        
        let bottomStartOrigin = takeUpperMargin ? cellRect.origin.y : topPartHeight
        let bottomPartHeight = UIScreen.main.bounds.height - bottomStartOrigin
        let bottomImage = UIImage.crop(source: layerImage!, frame: CGRect(x: 0, y: bottomStartOrigin, width: width, height: bottomPartHeight))
        
        topPart = UIImageView()
        topPart.translatesAutoresizingMaskIntoConstraints = false
        topPart.contentMode = .scaleAspectFit
        topPart.image = topImage
        view.addSubview(topPart)
        
        let views1 = ["view" : topPart]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views1))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(\(bottomStartOrigin))]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views1))
        lcTop = NSLayoutConstraint(item: topPart, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        view.addConstraint(lcTop)
        
        
        bottomPart = UIImageView()
        bottomPart.translatesAutoresizingMaskIntoConstraints = false
        bottomPart.contentMode = .scaleAspectFit
        bottomPart.image = bottomImage
        view.addSubview(bottomPart)
        
        let views2 = ["view" : bottomPart]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views2))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(\(bottomPartHeight))]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views2))
        lcBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: bottomPart, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(lcBottom)
    }
    
    func startAnimation() {
        let isClose = lcTop.constant == 0
        lcTop.constant = isClose ? -topPart.bounds.height : 0
        lcBottom.constant = isClose ? -bottomPart.bounds.height : 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            if isClose {
                self.topPart.alpha = 0
                self.bottomPart.alpha = 0
            } else {
                self.topPart.alpha = 1
                self.bottomPart.alpha = 1
            }
            }, completion: { (completed) in
                if !isClose {
                    _ = self.navigationController?.popViewController(animated: false)
                }
        }) 
    }
}
