//
//  MyToolItemButton.swift
//  PaintX2
//
//  Created by New Idea on 2018/12/25.
//  Copyright © 2018 Charley. All rights reserved.
//

import Cocoa
import NBCore

/// MyToolItemButton is a button
class MyToolItemButton: MyCommonSelectableButton {
}



/// 此view上有一个iconImageView用来显示图标
//class MyToolItemButton: ControlView
//{
//    // MARK: - Properties
//    private var isSelected: Bool = false
//
//    /// Subviews
//    private var iconImageView: NSImageView!
//
//    /// 2-step construct
//    override func customInit()
//    {
//        super.customInit()
//
//        // Config self's properties
//        // 因为在tableview row中的NSView收不到mouseUp事件。
//        self.sendActionOnMouseUp = false
//
//        // icon image view
//        let iconView = NSImageView.createStaticImageView()
//        iconView.translatesAutoresizingMaskIntoConstraints = false
//
//        // Add to view
//        self.addSubview(iconView)
//
//        // 设置Autolayout
//        var allConstraints: [NSLayoutConstraint] = []
//
//        let metrics: [String : NSNumber] = [:]
//        let views: [String : Any] = [
//            "icon": iconView,
//        ]
//
//        // Icon-View: 水平Constraints
//        let horizontalConstraintsOfIconView = NSLayoutConstraint.constraints(
//            withVisualFormat: "|-0-[icon]-0-|",
//                     options: [],
//                     metrics: metrics,
//                       views: views)
//        allConstraints += horizontalConstraintsOfIconView
//
//        // Icon-View: 垂直Constraints
//        let verticalConstraintsOfIconView = NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-0-[icon]-0-|",
//                     options: [],
//                     metrics: metrics,
//                       views: views)
//        allConstraints += verticalConstraintsOfIconView
//
//        // Active all constrants
//        NSLayoutConstraint.activate(allConstraints)
//
//        // Save
//        self.iconImageView = iconView
//    }
//
//    /// Drawing
//    override func draw(_ dirtyRect: NSRect)
//    {
//        super.draw(dirtyRect)
//
//        // Drawing code here.
//        if (self.isSelected)
//        {
//            let boundingRect: NSRect = self.bounds
//
//            // Draw a selected background color
//            let bgPath: NSBezierPath = NSBezierPath(roundedRect: boundingRect, xRadius: 4, yRadius: 4)
//            Colors.toolboxItemSelectedBackgroundColor.setFill()
//            bgPath.fill()
//        }
//    }
//
//    /// Update values
//    func updateValues(iconImage: NSImage?, selected: Bool)
//    {
//        self.iconImageView.image = iconImage
//        self.isSelected = selected
//        self.invalidateEntireRect()
//    }
//}
