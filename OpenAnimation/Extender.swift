//
//  Extender.swift
//  OpenAnimation
//
//  Created by Tapas Pal on 11/06/16.
//  Copyright © 2016 Contrivance. All rights reserved.
//  http://www.contrivanceinfo.com
//

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

extension UIImage {
    
    static func snapshotOfWindow() -> UIImage {
        let window = UIApplication.sharedApplication().delegate!.window!!
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, true, 0.0)
        window.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    static func crop(source sourceImage: UIImage, frame targetFrame: CGRect) -> UIImage {
        let frame = CGRectMake(targetFrame.origin.x * sourceImage.scale, targetFrame.origin.y * sourceImage.scale, targetFrame.size.width * sourceImage.scale, targetFrame.size.height * sourceImage.scale)
        let imageRef = CGImageCreateWithImageInRect(sourceImage.CGImage, frame)!
        return UIImage(CGImage: imageRef, scale: sourceImage.scale, orientation: sourceImage.imageOrientation)
    }
}