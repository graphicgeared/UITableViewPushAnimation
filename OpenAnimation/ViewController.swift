//
//  ViewController.swift
//  OpenAnimation
//
//  Created by Tapas Pal on 11/06/16.
//  Copyright © 2016 Contrivance. All rights reserved.
//  http://www.contrivanceinfo.com
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Open Animation"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}


extension ViewController {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let randomNumber = arc4random_uniform(9)
        let identifier = randomNumber % 2 == 0 ? "default" : "default-right"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)!
        let textLabel = cell.contentView.viewWithTag(1) as! UILabel
        textLabel.text = "\(indexPath.row + 1). \(identifier == "default-right" ? "iPhone 5s, iPhone 6, iPhone 6 Plus" : "iPhone 6")"
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        let window = UIApplication.sharedApplication().delegate!.window!!
        var cellRect = cell.convertRect(window.bounds, toView: nil)
        cellRect.size.height = cell.bounds.size.height
        
        let targetController = storyboard?.instantiateViewControllerWithIdentifier("TargetViewController") as! TargetViewController
        targetController.layerImage = UIImage.snapshotOfWindow()
        targetController.cellRect = cellRect
        navigationController?.pushViewController(targetController, animated: false)
        navigationController?.navigationBarHidden = true
    }
}


