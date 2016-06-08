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

    var media:[(index:Int, phAsset:PHAsset?, urlString:String?)] = [];
        
    @IBOutlet weak var videoList: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadVideoList()
    
    }

    func loadVideoList()
    {
        let videos = PHAsset.fetchAssetsWithMediaType(.Video, options:nil)
        
        print("\(videos)")
        
        self.media.removeAll()
        
        videos.enumerateObjectsUsingBlock(
        { (enumeratedObject, index, stopPointer) in
            let video = enumeratedObject as! PHAsset
            let imageManager = PHImageManager.defaultManager()
            
            
            imageManager.requestAVAssetForVideo(video, options: nil, resultHandler:
            { (avAsset:AVAsset?, audoMix:AVAudioMix?, info:[NSObject : AnyObject]?) in
                
                let avUrlAsset = avAsset as? AVURLAsset
                print("\(index) \(avUrlAsset?.URL.absoluteString)")
                
                self.media.append((index, nil, avUrlAsset?.URL.absoluteString))

                if self.media.count == videos.count
                {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.videoList.reloadData()
                    })
                
                    print("reload")
                    
                }
            })
            
        })
        

    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print ("number of rows = \(self.media.count) in section \(section)")
        return self.media.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("bvpcell")!;
        let urlString = self.media[indexPath.row].urlString
        let videoFileName = urlString?.substringFromIndex((urlString?.rangeOfString("/", options: .BackwardsSearch)!.startIndex)!.advancedBy(1))
        cell.textLabel?.text = videoFileName
        cell.detailTextLabel?.text = "\(NSDate())"

        print("cell for row \(indexPath.row), movie=\(videoFileName!) count = \(self.media.count)")

        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        guard let videoAddress = self.media[indexPath.row].urlString else {return}
        print("Play \(videoAddress)")
    }
    
    
}




