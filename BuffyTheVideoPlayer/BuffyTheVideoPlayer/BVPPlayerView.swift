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


public class BVPPlayerView: UIView
{
  let KEYPATH_STATUS = "status"
  let KEYPATH_BUFFER_EMPTY = "playbackBufferEmpty"
  let KEYPATH_PLAYBACK_CAN_KEEP_UP = "playbackLikelyToKeepUp"
  let KEYPATH_LOADED_TIME_RANGES = "loadedTimeRanges"
  let BUFFER_PLAYBACK_THRESHOLD = 10000
  
  var player = AVPlayer()
  var playerLayer: AVPlayerLayer?
  var playerItem: AVPlayerItem?
  var observers = [NSObjectProtocol]()
  
  let control = BVPControlOverlay()
  
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit()
  {
    layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(alpha).CGColor;
    layer.borderWidth = 0.3
    
    constraintsForControlOverlay()
  }
  
  public func constraintsForControlOverlay()
  {
    let views = ["player":self, "overlay":control];
    
    control.hidden = false
    control.backgroundColor = UIColor.orangeColor()
    control.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(control)
    addConstraints( NSLayoutConstraint.visualConstraints("H:|-0-[overlay]-0-|", views:views) )
    addConstraints( NSLayoutConstraint.visualConstraints("V:[overlay(30)]-|", views:views) )
    
  }
  
  override public func layoutSubviews()
  {
    super.layoutSubviews()
    redraw()
  }
  
  func play()
  {
    player.play()
  }
  

  func setupPlayerLayer()
  {
    playerLayer?.removeFromSuperlayer()
    playerLayer = AVPlayerLayer(player: player)
    
    playerLayer!.frame = bounds
    playerLayer!.videoGravity = AVLayerVideoGravityResizeAspect
    layer.addSublayer(playerLayer!)
    self.layer.borderWidth = 0.0

    
    bringSubviewToFront(control)
  }
  
  public func playUrl(videoUrl:NSURL)
  {
    print ("Now playing: \(videoUrl.absoluteString)")
    
    unregisterForPlayerEvents()
    setupPlayer(videoUrl)
    setupPlayerLayer()
    registerForPlayerEvents()

    play()
    
  }
  
  func redraw()
  {
    CATransaction.begin()
    playerLayer?.frame = bounds
    bringSubviewToFront(control)
    CATransaction.disableActions()
    CATransaction.commit()
  }
  
  func setupPlayer(url:NSURL)
  {
    
    playerItem = AVPlayerItem(URL: url)

    player = AVPlayer(playerItem: playerItem!)
    
    player.currentItem?.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmTimeDomain;
    
    player.currentItem?.canUseNetworkResourcesForLiveStreamingWhilePaused = true;
    player.currentItem?.preferredPeakBitRate = 2500000; // 2.5 Mbps
  
    player.actionAtItemEnd = .None;
  
  }
  
 
  func unregisterForPlayerEvents()
  {
    guard player.currentItem != nil else {return}
    
    let _ = observers.map { (observer:NSObjectProtocol) -> () in
      NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    
    player.removeObserver(self, forKeyPath: KEYPATH_STATUS)
    
    player.currentItem?.removeObserver(self, forKeyPath: KEYPATH_BUFFER_EMPTY)
    
    player.currentItem?.removeObserver(self, forKeyPath: KEYPATH_PLAYBACK_CAN_KEEP_UP)
    
    player.currentItem?.removeObserver(self, forKeyPath: KEYPATH_LOADED_TIME_RANGES)
  }
  
  
  func registerForPlayerEvents()
  {
    observers.removeAll()

    var observer = NSNotificationCenter.defaultCenter().addObserverForName(AVPlayerItemDidPlayToEndTimeNotification, object: player.currentItem!, queue: nil)
    { [unowned self] (notification:NSNotification) in
      self.itemFinishedPlaying(notification)
    }
    
    observers.append(observer)
    
    observer = NSNotificationCenter.defaultCenter().addObserverForName(AVPlayerItemTimeJumpedNotification, object: player.currentItem!, queue: nil)
    { [unowned self] (notification:NSNotification) in
      self.jumpedToTime(notification)
    }
    
    observers.append(observer)
    
    player.addObserver(self, forKeyPath: KEYPATH_STATUS, options: .New, context: nil)
    
    player.currentItem?.addObserver(self, forKeyPath: KEYPATH_BUFFER_EMPTY, options: .New, context: nil)
    
    player.currentItem?.addObserver(self, forKeyPath: KEYPATH_PLAYBACK_CAN_KEEP_UP, options: .New, context: nil)
    
    player.currentItem?.addObserver(self, forKeyPath: KEYPATH_LOADED_TIME_RANGES, options: .New, context: nil)
  }
  
  func itemFinishedPlaying(notification:NSNotification)
  {
    print ("EVENT: finish")

  }
  
  func jumpedToTime(notification:NSNotification)
  {
    print ("EVENT: jump")
    
  }
  
  
  override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>)
  {
    print ("EVENT: \(keyPath)")
  }
  
  
  
}
