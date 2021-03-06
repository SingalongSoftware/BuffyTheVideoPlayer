//
//  ViewController.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-04-01.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit
import Photos
import BuffyTheVideoPlayer

class BVPViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
  var videoCatalogue = BVPCatalogue()
  
  @IBOutlet weak var playerView: BVPPlayerView!
  @IBOutlet weak var videoList: UITableView!

  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    loadVideoList()
    
  }
  
  func loadVideoList()
  {
    videoCatalogue.fetch(.Video) {
      dispatch_async(dispatch_get_main_queue(),{
        self.videoList.reloadData()
      })
      
      print("reload")
    }
  }
  
  // MARK: UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    print ("number of rows = \(self.videoCatalogue.count) in section \(section)")
    return self.videoCatalogue.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier("bvpcell")!;
    let urlString = self.videoCatalogue[indexPath.row].url.absoluteString
    let videoFileName = urlString.substringFromIndex((urlString.rangeOfString("/", options: .BackwardsSearch)!.startIndex).advancedBy(1))
    cell.textLabel?.text = videoFileName
    cell.detailTextLabel?.text = "\(NSDate())"
    
    print("cell for row \(indexPath.row), movie=\(videoFileName) count = \(self.videoCatalogue.count)")
    
    
    return cell
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    let mediaData = videoCatalogue[indexPath.row]
    playerView.playUrl(mediaData.url)
  }
  
  
  
}




