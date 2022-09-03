//
//  MyCommonSelectableButton.swift
//  PaintX2
//
//  Created by New Idea on 2018/12/29.
//  Copyright © 2018 Charley. All rights reserved.
//

import Cocoa
import NBCore

///
/// 通用可选择按钮（主要用于：ToolboxItem按钮,)
///
class MyCommonSelectableButton: SelectButton
{
    /// "Normal" State: Background mark
    override var normalBackgroundMark: UniformImageMark? {
        return nil
    }
    
    /// "Normal" State: Image gray scale
    override var normalImageGrayScale: UniformGrayScale {
        return UniformGrayScale.secondaryIconGrayScale
    }
    
    /// "Selected" State: Background mark
    override var selectedBackgroundMark: UniformImageMark? {
        var bgMark = UniformImageMark()
        bgMark.isFilled = true
        bgMark.cornerRadius = 5
        bgMark.color = UniformColor.selectedIconBackgroundColor
        return bgMark
    }
    
    /// "Selected" State: Image gray scale
    override var selectedImageGrayScale: UniformGrayScale {
        return UniformGrayScale.selectedIconGrayScale
    }

}
