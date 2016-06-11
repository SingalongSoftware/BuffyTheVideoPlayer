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
  
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    border(0.3)
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    border(0.3)
  }
  
  func border(alpha:CGFloat)
  {
    self.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(alpha).CGColor;
    self.layer.borderWidth = 0.3
  }
  
  override func layoutSubviews()
  {
    super.layoutSubviews()
    redraw()
  }
  
  func play()
  {
    guard let item = playerItem else {return}
    
    player = AVPlayer(playerItem: item)
    playerLayer?.removeFromSuperlayer()
    
    playerLayer = AVPlayerLayer(player: player)
    playerLayer!.frame = bounds
    layer.addSublayer(playerLayer!)
    border(0)
    
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
    playerLayer?.frame = bounds
    CATransaction.disableActions()
    CATransaction.commit()
  }
  
  
}
