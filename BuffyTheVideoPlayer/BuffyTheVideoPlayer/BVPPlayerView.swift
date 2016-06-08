//
//  BVPPlayerView.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-04-01.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit
import AVFoundation
import Photos


class BVPPlayerView: UIView
{
  var player = AVPlayer()
  var playerLayer = AVPlayerLayer()
  
  func play(videoAsset:PHAsset)
  {
  }
  
  func playUrl(videoUrl:NSURL)
  {
    print ("Now playing: \(videoUrl.absoluteString)")
    
    let item = AVPlayerItem(URL: videoUrl)
    player = AVPlayer(playerItem: item)
    playerLayer = AVPlayerLayer(player: player)
    
    playerLayer.frame = bounds
    
    layer.addSublayer(playerLayer)
    
    player.play()
  }
  
}
