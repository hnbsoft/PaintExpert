//
//  MyToolboxCollectionFooterView.swift
//  Seashore
//
//  Created by My Apps on 2019/9/2.
//

import Cocoa

/// class MyToolboxCollectionFooterView, that view must conform to the NSCollectionViewElement protocol
class MyToolboxCollectionFooterView: NSView, NSCollectionViewElement
{
    /// Outlets
    @IBOutlet weak var colorViewBox: NSBox!
    
    /// Config UI with a color view
    @objc public func configUI(withColorView colorView: NSView)
    {
        self.colorViewBox.contentView = colorView
    }
    
    /// Drawing function
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)

        // Drawing code here.
        // let path = NSBezierPath(roundedRect: self.bounds, xRadius: 4, yRadius: 4)
        // NSColor.red.setFill()
        // path.fill()
    }
}
