//
//  NSOutlineView_Extensions.h
//
//  Copyright (c) 2001-2005, Apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSOutlineView(MyExtensions)

- (NSArray *)allSelectedItems;
- (void)selectItems:(NSArray *)items byExtendingSelection:(BOOL)extend;

@end

@interface SeaOutlineView : NSOutlineView{
	// The document the outline view is in
	__weak IBOutlet id document;
}
@end

