//
//  BVPMedia.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-06-10.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit
import Photos

public class BVPMedia
{
  public var index:Int
  public var asset:PHAsset
  public var url:NSURL
  
  public init (index:Int, asset:PHAsset, url:NSURL)
  {
    self.index = index
    self.asset = asset
    self.url = url
  }
  
}
