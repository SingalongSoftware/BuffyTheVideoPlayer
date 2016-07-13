//
//  NSLayoutConstraint+VisualConstraints.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-07-12.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit

extension NSLayoutConstraint
{
  
  class func visualConstraints(format:String, views: [String:AnyObject]) -> [NSLayoutConstraint]
  {
    return NSLayoutConstraint.constraintsWithVisualFormat(format, options: [], metrics: nil, views: views)
  }

}
