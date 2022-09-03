//
//  NSCursor_Ext.swift
//  Seashore
//
//  Created by My Apps on 2019/8/31.
//

import Foundation

///
/// Extension to create cursor easily.
///
public extension NSCursor
{
    /// Define some predefined hotspot corners.
    @objc static let kHotSpotPointTopLeft: NSPoint     = NSPoint(x: -91000, y: -91000)
    @objc static let kHotSpotPointTopRight: NSPoint    = NSPoint(x: -92000, y: -92000)
    @objc static let kHotSpotPointBottomLeft: NSPoint  = NSPoint(x: -93000, y: -93000)
    @objc static let kHotSpotPointBottomRight: NSPoint = NSPoint(x: -94000, y: -94000)
    @objc static let kHotSpotPointCenter: NSPoint      = NSPoint(x: -95000, y: -95000)

    /// Create a cursor with a given image name.
    @objc static func createCursor(imageName name: NSImage.Name, hotSpot point: NSPoint) -> NSCursor?
    {
        if let img: NSImage = NSImage(named: name)
        {
            let revisedPoint: NSPoint
            let imgSize: NSSize = img.size
            if (imgSize.width >= 1 && imgSize.height >= 1)
            {
                if (point == kHotSpotPointTopLeft) {
                    revisedPoint = NSPoint.zero
                }
                else if (point == kHotSpotPointTopRight) {
                    revisedPoint = NSPoint(x: (imgSize.width - 1.0), y: 0)
                }
                else if (point == kHotSpotPointBottomLeft) {
                    revisedPoint = NSPoint(x: 0, y: (imgSize.height - 1.0))
                }
                else if (point == kHotSpotPointBottomRight) {
                    revisedPoint = NSPoint(x: (imgSize.width - 1.0), y: (imgSize.height - 1.0))
                }
                else if (point == kHotSpotPointCenter) {
                    revisedPoint = NSPoint(x: CGFloat(Int((imgSize.width - 1.0) * 0.5)),
                                           y: CGFloat(Int((imgSize.height - 1.0) * 0.5)))
                }
                else {
                    revisedPoint = point
                }
            }
            else {
                revisedPoint = NSPoint.zero
            }

            return NSCursor(image: img, hotSpot: revisedPoint)
        }
        
        // Error
        return nil
    }
}
