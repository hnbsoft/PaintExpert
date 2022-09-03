//
//  UniformColorExt.swift
//  PaintX2
//
//  Created by New Idea on 2018/12/20.
//  Copyright © 2018 Charley. All rights reserved.
//

import Foundation
import NBCore

///
/// Extension initializers for `UniformColor`
///
extension UniformColor
{
    /// Initializer, create `UniformColor` with (r, g, b, a) for `anyColor`
    convenience init(_ anyColor: (Int, Int, Int, Int)) {
        let color: NSColor = NSColor(srgbRed: CGFloat(anyColor.0)/255.0,
                                       green: CGFloat(anyColor.1)/255.0,
                                        blue: CGFloat(anyColor.2)/255.0,
                                       alpha: CGFloat(anyColor.3)/255.0)
        self.init(color)
    }
    
    /// Initializer, create `UniformColor` with (r, g, b, a) for `anyColor` and `darkColor`
    convenience init(_ anyColor: (Int, Int, Int, Int), darkColor: (Int, Int, Int, Int)) {
        let anyColorObj: NSColor = NSColor(srgbRed: CGFloat(anyColor.0)/255.0,
                                             green: CGFloat(anyColor.1)/255.0,
                                              blue: CGFloat(anyColor.2)/255.0,
                                             alpha: CGFloat(anyColor.3)/255.0)
        
        let darkColorObj: NSColor = NSColor(srgbRed: CGFloat(darkColor.0)/255.0,
                                              green: CGFloat(darkColor.1)/255.0,
                                               blue: CGFloat(darkColor.2)/255.0,
                                              alpha: CGFloat(darkColor.3)/255.0)
        self.init(anyColorObj, darkColor: darkColorObj)
    }
    
    /// Initializer, create `UniformColor` with (r, g, b) for `anyColor`
    convenience init(_ anyColor: (Int, Int, Int)) {
        self.init((anyColor.0, anyColor.1, anyColor.2, 255))
    }
    
    /// Initializer, create `UniformColor` with (r, g, b) for `anyColor` and `darkColor`
    convenience init(_ anyColor: (Int, Int, Int), darkColor: (Int, Int, Int)) {
        self.init((anyColor.0, anyColor.1, anyColor.2, 255), darkColor: (darkColor.0, darkColor.1, darkColor.2, 255))
    }
}

///
/// Extension semantic colors for `UniformColor`
///
extension UniformColor
{
    /// 容器视图背景色
    public static let containerBackgroundColor: UniformColor = UniformColor((240, 240, 240), darkColor: (61, 61, 61))
    
    /// 容器视图分割线/边框线颜色
    public static let containerBorderColor: UniformColor = UniformColor((215, 215, 215), darkColor: (3, 3, 3))
    
    /// 控件边框色
    public static let controlBorderColor: UniformColor = UniformColor((245, 245, 245), darkColor:(5, 5, 5))
    
    /// 控件交替边框色
    public static let controlAlternatingBorderColor: UniformColor = UniformColor((180, 180, 180), darkColor:(80, 80, 80))
    
    /// 选中状态的控件边框色
    public static let selectedControlBorderColor: UniformColor = UniformColor((245, 245, 245), darkColor:(5, 5, 5))
    
    /// 选中状态的控件交替边框色
    public static let selectedControlAlternatingBorderColor: UniformColor = UniformColor((100, 100, 100), darkColor:(160, 160, 160))
    
    /// icon被选中时的背景色
    public static let selectedIconBackgroundColor: UniformColor = UniformColor((98, 98, 98), darkColor: (200, 200, 200))

    /// icon被选中时的加强背景颜色
    public static let emphasizedSelectedIconBackgroundColor: UniformColor = UniformColor(NSColor.systemBlue, darkColor: NSColor.systemBlue)
    
    /// grid边框色
    public static let gridBorderColor: UniformColor = UniformColor((0, 0, 0, 28), darkColor:(255, 255, 255, 28))
    
    /// grid高亮边框色
    public static let gridHighlightBorderColor: UniformColor = UniformColor((0, 0, 0, 238), darkColor:(255, 255, 255, 238))
    
    /// grid交替高亮边框色
    public static let gridAlternatingHighlightBorderColor: UniformColor = UniformColor((255, 255, 255, 238), darkColor:(0, 0, 0, 238))
}
