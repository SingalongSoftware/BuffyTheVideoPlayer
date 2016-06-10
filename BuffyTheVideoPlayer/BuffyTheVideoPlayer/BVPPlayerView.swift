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
  var playerLayer: AVPlayerLayer?
  var playerItem: AVPlayerItem?
  
  override func layoutSubviews()
  {
    super.layoutSubviews()
    redraw()
  }
  
  func play()
  {
    guard let item = playerItem else {return}
    
    player = AVPlayer(playerItem: item)
    
    if let playerLayer = playerLayer
    {
      playerLayer.removeFromSuperlayer()
    }
    
    playerLayer = AVPlayerLayer(player: player)
    
    playerLayer!.frame = bounds
    layer.addSublayer(playerLayer!)
    
    player.play()

  }
  
  func playUrl(videoUrl:NSURL)
  {
    print ("Now playing: \(videoUrl.absoluteString)")
    playerItem = AVPlayerItem(URL: videoUrl)
    play()
  }
  
  func redraw()
  {
    CATransaction.begin()
    CATransaction.disableActions()
    playerLayer?.frame = bounds
    CATransaction.commit()
  }
  
  
}
