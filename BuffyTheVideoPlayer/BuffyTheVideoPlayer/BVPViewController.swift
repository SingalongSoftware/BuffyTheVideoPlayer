//
//  ViewController.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-04-01.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit
import Photos

class BVPViewController: UIViewController, UITableViewDelegate
{

    var media:[(String, String)] = [];
    
    @IBOutlet weak var playerView: BVPPlayerView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let videos = PHAsset.fetchAssetsWithMediaType(.Video, options:nil)
        
        print("\(videos)")
        
//        videos.enumerateObjectsUsingBlock { (<#AnyObject#>, <#Int#>, <#UnsafeMutablePointer<ObjCBool>#>) in
//            <#code#>
//        }
        videos.enumerateObjectsUsingBlock(
        { (enumeratedObject, index, stopPointer) in
            let video = enumeratedObject as! PHAsset
//            let stop = stopPointer.memory.boolValue
            
//            print ("\(video), \(index), \(stop)")
            
//            print ("DESC: \(video.description)")
            print ("\(index) LOCAL IDENT: \(video.localIdentifier)")
            
        })
        
        var color1 = UIColor.purpleColor()
        var color2 = UIColor.orangeColor()
        print ("\(color1.getComponents())")
        print ("\(color2.getComponents())")
        print ("\(UIColor.gradientPoint(factor: 0.5, color1: color1, color2: color2))")
        print ("\(UIColor.gradientPoint(factor: 0.01, color1: color1, color2: color2))")
        
        playerView.backgroundColor = UIColor.gradientPoint(factor: 1, color1: color1, color2: color2)
        
        color1 = UIColor.whiteColor()
        color2 = UIColor.blackColor()
        print ("\(color1.getComponents())")
        print ("\(color2.getComponents())")
        print ("\(UIColor.gradientPoint(factor: 0.5, color1: color1, color2: color2))")
        
    }
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("bvpcell")!;
        cell.textLabel?.text = "Main Text"
        cell.detailTextLabel?.text = "Subtext"
        return cell
        
    }
    
}

extension UIColor {
    class func gradientPoint(factor factor:CGFloat, color1:UIColor, color2:UIColor) -> UIColor
    {
//        var r1:CGFloat = 0, g1:CGFloat = 0, b1:CGFloat = 0, alpha1:CGFloat = 0
//        var r2:CGFloat = 0, g2:CGFloat = 0, b2:CGFloat = 0, alpha2:CGFloat = 0
//        
//        color1.getRed(&r1, green: &g1, blue: &b1, alpha:&alpha1)
//        color2.getRed(&r2, green: &g2, blue: &b2, alpha:&alpha2)
        
        let c1 = color1.getComponents()
        let c2 = color2.getComponents()
        
//        let newR = min(c1.red, c2.red) + (factor*abs(c2.red-c1.red))
//        let newG = min(c1.green, c2.green) + (factor*abs(c2.green-c1.green))
//        let newB = min(c1.blue, c2.blue) + (factor*abs(c2.blue-c1.blue))
        
        let newR = c1.red + (factor*(c2.red-c1.red))
        let newG = c1.green + (factor*(c2.green-c1.green))
        let newB = c1.blue + (factor*(c2.blue-c1.blue))

        return UIColor.init(red: newR, green: newG, blue: newB, alpha: 1.0)
    }
    
    func getComponents() -> (red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)
    {
        var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0, alpha:CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }

}


