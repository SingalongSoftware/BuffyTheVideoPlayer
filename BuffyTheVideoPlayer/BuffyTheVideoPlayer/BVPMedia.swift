//
//  BVPMedia.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-06-10.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit
import Photos

class BVPMedia
{

  var index:Int
  var asset:PHAsset
  var url:NSURL
  
  init (index:Int, asset:PHAsset, url:NSURL)
  {
    self.index = index
    self.asset = asset
    self.url = url
  }
  
}
