//
//  UniformGrayScaleExt.swift
//  PaintX2
//
//  Created by New Idea on 2019/1/3.
//  Copyright © 2019 Charley. All rights reserved.
//

import Cocoa
import NBCore

///
/// Extension semantic gray scale for `UniformGrayScale`
///
extension UniformGrayScale
{
    /// The gray scale to use for icon image.
    public static let iconGrayScale: UniformGrayScale = UniformGrayScale(67, darkGrayScale: 200)
    
    /// icon交替边框色
    public static let iconAlternatingGrayScale: UniformGrayScale = UniformGrayScale(134, darkGrayScale: 250)
    
    /// The secondary gray scale to use for icon image.
    public static let secondaryIconGrayScale: UniformGrayScale = UniformGrayScale(98, darkGrayScale: 200)
    
    /// The selected gray scale to use for icon image.
    public static let selectedIconGrayScale: UniformGrayScale = UniformGrayScale(230, darkGrayScale: 53)
    
    /// icon被选中时的加强背景颜色
    public static let emphasizedsSelectedIconGrayScale: UniformGrayScale = UniformGrayScale(230, darkGrayScale: 255)
    
    /// White gray scale
    public static let whiteGrayScale: UniformGrayScale = UniformGrayScale(255, darkGrayScale: 255)
    
    /// Black gray scale
    public static let blackGrayScale: UniformGrayScale = UniformGrayScale(0, darkGrayScale: 0)
}
