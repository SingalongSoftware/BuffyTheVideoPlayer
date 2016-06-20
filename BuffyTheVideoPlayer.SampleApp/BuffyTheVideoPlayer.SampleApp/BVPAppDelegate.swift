//
//  AppDelegate.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-04-01.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit
import AVFoundation
import BuffyTheVideoPlayer

@UIApplicationMain
class BVPAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

      let _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)

      
      return true
    }
    

}

