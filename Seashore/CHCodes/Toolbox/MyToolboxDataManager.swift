//
//  MyToolboxDataManager.swift
//  Seashore
//
//  Created by My Apps on 2019/8/29.
//

import Foundation

class MyToolboxDataManager: NSObject
{
    /// Properties
    private let toolTags: [Int] =  [
                                       kWandTool,
                                       kPositionTool,
                                       kRectSelectTool,
                                       kEllipseSelectTool,
                                       kLassoTool,
                                       kPolygonLassoTool,
                                       kCropTool,
                                       kTextTool,
                                       kPencilTool,
                                       kBrushTool,
                                       kBucketTool,
                                       kEraserTool,
                                       kCloneTool,
                                       kSmudgeTool,
                                       kGradientTool,
                                       kEffectTool,
                                       kEyedropTool,
                                       kZoomTool
                                 ]
    
    /// Initializers
    override init() {
        super.init()
    }
    
    /// MARK: - Public Methods
    /// Find all the number of tool items.
    @objc func findNumberOfToolItems() -> NSInteger {
        return self.toolTags.count
    }
    
    /// Find the tool tag for a given index
    @objc func findToolTagFor(index findingIndex: NSInteger) -> NSNumber?
    {
        for (i, tag) in self.toolTags.enumerated() {
            if (findingIndex == i) {
                return NSNumber(value: tag)
            }
        }
        
        // Not found
        return nil
    }
}
