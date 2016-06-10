//
//  ViewController.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-04-01.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit
import Photos

class BVPViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
  var catalogue = BVPCatalogue()
  
  @IBOutlet weak var playerView: BVPPlayerView!
  @IBOutlet weak var videoList: UITableView!

  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    loadVideoList()
    
  }
  
  func loadVideoList()
  {
    catalogue.fetch { 
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
    print ("number of rows = \(self.catalogue.count) in section \(section)")
    return self.catalogue.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier("bvpcell")!;
    let urlString = self.catalogue[indexPath.row].url.absoluteString
    let videoFileName = urlString.substringFromIndex((urlString.rangeOfString("/", options: .BackwardsSearch)!.startIndex).advancedBy(1))
    cell.textLabel?.text = videoFileName
    cell.detailTextLabel?.text = "\(NSDate())"
    
    print("cell for row \(indexPath.row), movie=\(videoFileName) count = \(self.catalogue.count)")
    
    
    return cell
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    let mediaData = self.catalogue[indexPath.row]

    playerView.playPHAsset(mediaData.asset)

    playerView.playUrl(mediaData.url)
  }
  
  
  
}




