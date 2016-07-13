//
//  BVPSeeker.swift
//  BuffyTheVideoPlayer
//
//  Created by asu on 2016-04-07.
//  Copyright © 2016 Singalong Software. All rights reserved.
//

import UIKit

@IBDesignable

public class BVPControlOverlay: UIView
{
  var pausePlayButton: UIButton = UIButton()
  var stopButton: UIButton = UIButton()
  var seekBar: UIView = UIView()
  
  public override init (frame : CGRect)
  {
    super.init(frame : frame)
    commonInit()
  }
  
  convenience init ()
  {
    self.init(frame:CGRect.zero)
    commonInit()
  }
  
  public convenience required init(coder aDecoder: NSCoder)
  {
    self.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit ()
  {
    let views = ["thisView":self, "pausePlayButton":pausePlayButton];

    for view in views.values
    {
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    addSubview(pausePlayButton)
    pausePlayButton.backgroundColor = UIColor.blueColor()
    addConstraints( NSLayoutConstraint.visualConstraints("H:|-0-[pausePlayButton(20)]", views:views) )
    addConstraints( NSLayoutConstraint.visualConstraints("V:|-0-[pausePlayButton(20)]", views:views) )

  }
  
  
}
