//
//  MyToolboxCollectionViewItem.swift
//  Seashore
//
//  Created by My Apps on 2019/8/29.
//

import Cocoa
import NBCore

///
/// MyToolboxCollectionViewItem Delegate
///
@objc protocol MyToolboxCollectionViewItemDelegate: AnyObject {
    @objc optional func toolboxCollectionViewItemExecuteAction(withToolItemButton toolItemButton: MyToolItemButton?)
}

///
/// Class MyToolboxCollectionViewItem
///
class MyToolboxCollectionViewItem: NSCollectionViewItem
{
    // Delegate
    @objc weak var delegate: MyToolboxCollectionViewItemDelegate? = nil
    
    // Outlets
    @IBOutlet weak var toolItemButton: MyToolItemButton!
    
    // Current tool tag
    // var currentToolTag: NSInteger? = nil
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Config UI with a tool tag
    @objc func configUI(withToolTag toolTag: NSInteger, selected: Bool)
    {
        var iconImgName: String
        var toolTipStr: String
        
        switch toolTag
        {
            case kRectSelectTool:
                iconImgName = "TXSelectionRectTemplate"
                toolTipStr = NSLocalizedString("Rectangle Select Tool", comment: "")
                break
            
            case kEllipseSelectTool:
                iconImgName = "TXSelectionEllipseTemplate"
                toolTipStr = NSLocalizedString("Ellipse Select Tool", comment: "")
                break
            
            case kLassoTool:
                iconImgName = "TXSelectionLassoTemplate"
                toolTipStr = NSLocalizedString("Lasso Select Tool", comment: "")
                break
            
            case kPolygonLassoTool:
                iconImgName = "TXSelectionPolygonLassoTemplate"
                toolTipStr = NSLocalizedString("Polygon Lasso Tool", comment: "")
                break
            
            case kWandTool:
                iconImgName = "TXSelectionWandTemplate"
                toolTipStr = NSLocalizedString("Wand Select Tool", comment: "")
                break
            
            case kPencilTool:
                iconImgName = "TXPencilTemplate"
                toolTipStr = NSLocalizedString("Pencil Tool", comment: "")
                break
            
            case kBrushTool:
                iconImgName = "TXBrushTemplate"
                toolTipStr = NSLocalizedString("Brush Tool", comment: "")
                break
            
            case kTextTool:
                iconImgName = "TXTextTemplate"
                toolTipStr = NSLocalizedString("Text Tool", comment: "")
                break
            
            case kEraserTool:
                iconImgName = "TXEraserTemplate"
                toolTipStr = NSLocalizedString("Eraser Tool", comment: "")
                break
            
            case kBucketTool:
                iconImgName = "TXPaintBucketTemplate"
                toolTipStr = NSLocalizedString("Bucket Tool", comment: "")
                break
            
            case kGradientTool:
                iconImgName = "TXGradientTemplate"
                toolTipStr = NSLocalizedString("Gradient Tool", comment: "")
                break
            
            case kEffectTool:
                iconImgName = "TXEffectsTemplate"
                toolTipStr = NSLocalizedString("Effects Tool", comment: "")
                break
            
            case kSmudgeTool:
                iconImgName = "TXSmudgeTemplate"
                toolTipStr = NSLocalizedString("Smudge Tool", comment: "")
                break
            
            case kCloneTool:
                iconImgName = "TXCloneTemplate"
                toolTipStr = NSLocalizedString("Clone Tool", comment: "")
                break
            
            case kEyedropTool:
                iconImgName = "TXEyedropperTemplate"
                toolTipStr = NSLocalizedString("Eyedrop Tool", comment: "")
                break
            
            case kCropTool:
                iconImgName = "TXCropTemplate"
                toolTipStr = NSLocalizedString("Crop Tool", comment: "")
                break
            
            case kZoomTool:
                iconImgName = "TXZoomTemplate"
                toolTipStr = NSLocalizedString("Zoom Tool", comment: "")
                break
            
            case kPositionTool:
                iconImgName = "TXMoveTemplate"
                toolTipStr = NSLocalizedString("Position Tool", comment: "")
                break
            
            default:
                iconImgName = ""
                toolTipStr = ""
                Debug.e("Not support tool tag:\(toolTag)")
                break
        }
        
        // Config to bool item button
        Debug.verify(self.toolItemButton != nil, "No tool item button")
        self.toolItemButton?.tag = toolTag
        self.toolItemButton?.iconTemplateImageName = (iconImgName.isEmpty ? nil : iconImgName)
        self.toolItemButton?.setSelectedOnlyNeeded(selected)
        self.toolItemButton?.toolTip = toolTipStr
    }
}

/// Actions Extension
extension MyToolboxCollectionViewItem
{
    @IBAction func toolItemButtonDidClick(_ sender: Any?)
    {
        self.delegate?.toolboxCollectionViewItemExecuteAction?(withToolItemButton: self.toolItemButton)
    }
}
