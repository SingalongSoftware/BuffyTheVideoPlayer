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
  var playerItem: AVPlayerItem?
  
  override func layoutSubviews()
  {
    super.layoutSubviews()

    let anim = layer.animationForKey("bounds")
    
    CATransaction.begin()
    
//    if let anim = anim
//    {
//      CATransaction.setAnimationDuration(anim.duration)
//      CATransaction.setAnimationTimingFunction(anim.timingFunction)
//      let pathAnimation = CAPropertyAnimation(keyPath: "path")
//      playerLayer.addAnimation(pathAnimation, forKey: "path")
//      
//    }
//    else
//    {
//      CATransaction.disableActions()
//    }

    CATransaction.disableActions()
    
//    playerLayer.path/
//    playerLayer.path = UIBezierPath.bezierPathWithRect:self.bounds].CGPath;
    playerLayer. UIBezierPath(rect: bounds).CGPath
    playerLayer.frame =  bounds;

    CATransaction.commit()
  }
  
  
//  - (void)layoutSubviews {
//  [super layoutSubviews];
//  
//  // get current animation for bounds
//  CAAnimation *anim = [self.layer animationForKey:@"bounds"];
//  
//  [CATransaction begin];
//  if(anim) {
//  // animating, apply same duration and timing function.
//  [CATransaction setAnimationDuration:anim.duration];
//  [CATransaction setAnimationTimingFunction:anim.timingFunction];
//  
//  CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//  [self.borderLayer addAnimation:pathAnimation forKey:@"path"];
//  }
//  else {
//  // not animating, we should disable implicit animations.
//  [CATransaction disableActions];
//  }
//  
//  self.borderLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//  self.borderLayer.frame = self.bounds;
//  [CATransaction commit];
//  }
  
  override func layoutSublayersOfLayer(layer: CALayer) {
    super.layoutSublayersOfLayer(layer)
  }
  
  func play()
  {
    guard let item = playerItem else {return}
    
    player = AVPlayer(playerItem: item)
    playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = bounds
    layer.addSublayer(playerLayer)
    
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
    CATransaction.setDisableActions(false)
    playerLayer.frame = bounds
    CATransaction.commit()
  }
  
  
}
