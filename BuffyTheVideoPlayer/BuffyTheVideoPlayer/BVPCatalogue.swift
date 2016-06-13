//
//  BVPCatalogue.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-06-10.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit
import Photos

class BVPCatalogue
{
  let syncLock = dispatch_queue_create("BVPCatalogue.lock", nil)
  var media = [BVPMedia]()
  
  subscript(index: Int) -> BVPMedia
  {
    get
    {
      return media[index]
    }
  }
  
  var count:Int
  {
    get
    {
      return media.count
    }
  }
  
  func fetch(type:PHAssetMediaType, completion:(() -> Void)?)
  {
    let videos = PHAsset.fetchAssetsWithMediaType(type, options:nil)
    
    print("\(videos)")
    
    dispatch_sync(syncLock)
    {
      self.media.removeAll()
      
      videos.enumerateObjectsUsingBlock(
      { [unowned self] (enumeratedObject, index, stopPointer) in
          
        let video = enumeratedObject as! PHAsset
        let imageManager = PHImageManager.defaultManager()
        
        imageManager.requestAVAssetForVideo(video, options: nil, resultHandler:
        { [unowned self] (avAsset:AVAsset?, audoMix:AVAudioMix?, info:[NSObject : AnyObject]?) in
          
          dispatch_sync(self.syncLock)
          {
            let avUrlAsset = avAsset as? AVURLAsset
            print("\(index) \(avUrlAsset?.URL.absoluteString)")
            
            self.media.append(BVPMedia(index: index, asset: video, url: (avUrlAsset?.URL)!))
            
            print ("\(self.media.count) =?= \(videos.count)")
            if self.media.count == videos.count
            {
              completion?()
            }
          }
          
        })
        
      })
    }
  }
}
