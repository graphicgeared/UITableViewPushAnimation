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
        let window = UIApplication.shared.delegate!.window!!
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, true, 0.0)
        window.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func crop(source sourceImage: UIImage, frame targetFrame: CGRect) -> UIImage {
        let frame = CGRect(x: targetFrame.origin.x * sourceImage.scale, y: targetFrame.origin.y * sourceImage.scale, width: targetFrame.size.width * sourceImage.scale, height: targetFrame.size.height * sourceImage.scale)
        let imageRef = sourceImage.cgImage?.cropping(to: frame)!
        return UIImage(cgImage: imageRef!, scale: sourceImage.scale, orientation: sourceImage.imageOrientation)
    }
}
