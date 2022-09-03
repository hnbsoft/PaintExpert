#import "SeaDocumentController.h"
#import "SeaPrefs.h"
#import "SeaController.h"
#import "SeaDocument.h"
#import "Units.h"

@implementation SeaDocumentController

- (id)init
{
	if (![super init])
		return NULL;
		
	stopNotingRecentDocuments = NO;
	
	return self;
}

- (void)awakeFromNib
{
	int i;
    editableTypes = [NSMutableDictionary dictionary];
    viewableTypes = [NSMutableDictionary dictionary];
	
	// The document controller is responsible for tracking document types
	// In addition, as it's in control of open, it also must know the types for import and export
	NSArray *allDocumentTypes = [[[NSBundle mainBundle] infoDictionary]
							  valueForKey:@"CFBundleDocumentTypes"];
	for(i = 0; i < [allDocumentTypes count]; i++){
		NSDictionary *typeDict = [allDocumentTypes objectAtIndex:i];
		NSMutableSet *assembly = [NSMutableSet set];

		[assembly addObjectsFromArray:[typeDict objectForKey:@"CFBundleTypeExtensions"]];
		[assembly addObjectsFromArray:[typeDict objectForKey:@"CFBundleTypeOSTypes"]];
		[assembly addObjectsFromArray:[typeDict objectForKey:@"LSItemContentTypes"]];
		
		NSString* key = [typeDict objectForKey:@"CFBundleTypeName"];
		[assembly addObject:key];
				
		NSString *role = [typeDict objectForKey:@"CFBundleTypeRole"];
		if([role isEqual:@"Editor"]){
			[editableTypes setObject:assembly forKey: key];
		}else if ([role isEqual:@"Viewer"]) {
			[viewableTypes setObject:assembly forKey: key];
		}
	}
}

// Charley added
- (IBAction)hideNewPanel:(id)sender
{
    [newPanel orderOut:self];
}

- (IBAction)newDocument:(id)sender
{		
	NSString *string;
	id menuItem;
	IntSize size;
	
	// Set paper name
	if ([[NSPrintInfo sharedPrintInfo] respondsToSelector:@selector(localizedPaperName)]) {
		menuItem = [templatesMenu itemAtIndex:[templatesMenu indexOfItemWithTag:4]];
		string = [NSString stringWithFormat:@"%@ (%@)", LOCALSTR(@"paper size", @"Paper size"), [[NSPrintInfo sharedPrintInfo] localizedPaperName]];
		[menuItem setTitle:string];
	}

	// Display the panel for configuring
	units = [(SeaPrefs *)[SeaController seaPrefs] newUnits];
	[unitsMenu selectItemAtIndex: units];
    [unitsMenuHeight selectItemAtIndex: units]; // Charley added
	[resMenu selectItemAtIndex:[(SeaPrefs *)[SeaController seaPrefs] resolution]];
	[modeMenu selectItemAtIndex:[(SeaPrefs *)[SeaController seaPrefs] mode]];
	resolution = [[resMenu selectedItem] tag];
	size = [(SeaPrefs *)[SeaController seaPrefs] size];
	[widthInput setStringValue:StringFromPixels(size.width, units, resolution)];
	[heightInput setStringValue:StringFromPixels(size.height, units, resolution)];
	[heightUnits setStringValue:UnitsString(units)];
	[backgroundCheckbox setState:[(SeaPrefs *)[SeaController seaPrefs] transparentBackground]];
	
    // Charley added
    BOOL transBg = [(SeaPrefs *)[SeaController seaPrefs] transparentBackground];
    if (transBg) {
        [backgroundContentsMenu selectItemAtIndex:1];
    }
    else {
        [backgroundContentsMenu selectItemAtIndex:0];
    }
    
	// Set up the recents menu
    [recentTableView reloadData];
    
	int i;
	NSArray *recentDocs = [super recentDocumentURLs];
	if([recentDocs count]){
		[recentMenu setEnabled:YES];
		for(i = 0; i < [recentDocs count]; i++){
			NSString *path = [[recentDocs objectAtIndex:i] path];
			NSString *filename = [[path pathComponents] objectAtIndex:[[path pathComponents] count] -1];
			NSImage *image = [[NSWorkspace sharedWorkspace] iconForFile: path];
			[recentMenu addItemWithTitle: filename];
			[[recentMenu itemAtIndex:[recentMenu numberOfItems] - 1] setRepresentedObject:path];
			[[recentMenu itemAtIndex:[recentMenu numberOfItems] - 1] setImage: image];
		}
	}else {
		[recentMenu setEnabled:NO];
	}

	
	[newPanel center];
	[newPanel makeKeyAndOrderFront:self];
}

- (IBAction)openDocument:(id)sender
{
	[newPanel orderOut:self];
	[super openDocument:sender];
}

- (id)openNonCurrentFile:(NSString *)path
{
	SeaDocument *newDocument;
	
	stopNotingRecentDocuments = YES;
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSString *displayName = [path stringByAppendingString:@"(Original)"];
    NSURL *url0 = [NSURL fileURLWithPath:displayName];

    NSError *error;
    
    newDocument = [[NSDocumentController sharedDocumentController] duplicateDocumentWithContentsOfURL:url
                                                                                              copying:true
                                                                                          displayName:displayName
                                                                                                error:&error];
    [newDocument updateChangeCount:NSChangeCleared];
    [newDocument setFileURL:url0];
    
    NSString *title = [newDocument lastComponentOfFileName];
    NSWindow *win = (NSWindow*)[newDocument window];
    [win setTitle:title];

	stopNotingRecentDocuments = NO;
	
	return newDocument;
}

- (IBAction)openRecent:(id)sender
{
	[[NSDocumentController sharedDocumentController] openDocumentWithContentsOfFile:[[sender selectedItem] representedObject] display:YES];
}

- (void)noteNewRecentDocument:(NSDocument *)aDocument
{
	if (stopNotingRecentDocuments == NO && [(SeaDocument *)aDocument current]) {
		[super noteNewRecentDocument:aDocument];
	}
}

- (IBAction)createDocument:(id)sender
{
	// Determine the resolution
	resolution = [[resMenu selectedItem] tag];

	// Parse width and height	
	width = PixelsFromFloat([widthInput floatValue], units, resolution); 
	height = PixelsFromFloat([heightInput floatValue], units, resolution); 
			
	// Don't accept rediculous heights or widths
	if (width < kMinImageSize || width > kMaxImageSize) { NSBeep(); return; }
	if (height < kMinImageSize || height > kMaxImageSize) { NSBeep(); return; }
	
	// Determine everything else
	type = [modeMenu indexOfSelectedItem];
	opaque = ![backgroundCheckbox state];

    // Charley added
    opaque = (backgroundContentsMenu.indexOfSelectedItem == 0) ? YES : NO;
    
	// Create a new document
	[super newDocument:sender];
}

- (IBAction)changeToTemplate:(id)sender
{
	NSPasteboard *pboard;
	NSString *availableType;
	NSImage *image;
	NSSize paperSize;
	IntSize size = IntMakeSize(0, 0);
	float res;
	int selectedTag;
	
	selectedTag = [[templatesMenu selectedItem] tag];
	res = [[resMenu selectedItem] tag];
	switch (selectedTag) {
		case 1:
			size = [(SeaPrefs *)[SeaController seaPrefs] size];
			units = [(SeaPrefs *)[SeaController seaPrefs] newUnits];
			[unitsMenu selectItemAtIndex: units];
            [unitsMenuHeight selectItemAtIndex: units]; // Charley added
			res = [(SeaPrefs *)[SeaController seaPrefs] resolution];
			[resMenu selectItemAtIndex:res];
		break;
		case 2:
			pboard = [NSPasteboard generalPasteboard];
			availableType = [pboard availableTypeFromArray:[NSArray arrayWithObjects:NSTIFFPboardType, NSPICTPboardType, NULL]];
			if (availableType) {
				image = [[NSImage alloc] initWithData:[pboard dataForType:availableType]];
				size = NSSizeMakeIntSize([image size]);
			}
			else {
				NSBeep();
				return;
			}
			
		break;
		case 3:
			size = NSSizeMakeIntSize([[NSScreen mainScreen] frame].size);
			units = kPixelUnits;
			[unitsMenu selectItemAtIndex: kPixelUnits];
            [unitsMenuHeight selectItemAtIndex: kPixelUnits]; // Charley added
		break;
		case 4:
			paperSize = [[NSPrintInfo sharedPrintInfo] paperSize];
			paperSize.height -= [[NSPrintInfo sharedPrintInfo] topMargin] + [[NSPrintInfo sharedPrintInfo] bottomMargin];
			paperSize.width -= [[NSPrintInfo sharedPrintInfo] leftMargin] + [[NSPrintInfo sharedPrintInfo] rightMargin];
			size = NSSizeMakeIntSize(paperSize);
			units = kInchUnits;
			[unitsMenu selectItemAtIndex: kInchUnits];
            [unitsMenuHeight selectItemAtIndex: kInchUnits];// Charley added
			size.width = (float)size.width * (res / 72.0);
			size.height = (float)size.height * (res / 72.0);
		break;
		case 1000:
			/* Henry, add "Add..." item functionality here. */
		break;
		case 1001:
			/* Henry, add "Editor..." item functionality here. */
		break;
	}
	
	if (selectedTag != 1000 && selectedTag != 1001) {
		[widthInput setStringValue:StringFromPixels(size.width, units, res)];
		[heightInput setStringValue:StringFromPixels(size.height, units, res)];
		[heightUnits setStringValue:UnitsString(units)];
	}
}

- (IBAction)changeUnits:(id)sender
{
	IntSize size = IntMakeSize(0, 0);
	int res = [[resMenu selectedItem] tag];

	size.height =  PixelsFromFloat([heightInput floatValue],units,res);
	size.width =  PixelsFromFloat([widthInput floatValue],units,res);

	units = [[unitsMenu selectedItem] tag];
    // Charley added.
    if (unitsMenuHeight == sender) {
        units = [[unitsMenuHeight selectedItem] tag];
        [unitsMenu selectItemAtIndex: units];
    }
    else if (unitsMenu == sender) {
        [unitsMenuHeight selectItemAtIndex: units];
    }
    // ---
    
	[widthInput setStringValue:StringFromPixels(size.width, units, res)];
	[heightInput setStringValue:StringFromPixels(size.height, units, res)];
	[heightUnits setStringValue:UnitsString(units)];
}

- (void)addDocument:(NSDocument *)document
{
	[newPanel orderOut:self];
	[super addDocument:document];
}

- (void)removeDocument:(NSDocument *)document
{
	[super removeDocument:document];
}

- (int)type
{
	return type;
}

- (int)height
{
	return height;
}

- (int)width
{
	return width;
}

- (int)resolution
{
	return resolution;
}

- (int)opaque
{
	return opaque;
}

- (int)units
{
	return units;
}

- (NSMutableDictionary*)editableTypes
{
	return editableTypes;
}

- (NSMutableDictionary*)viewableTypes
{
	return viewableTypes;
}

- (NSArray*)readableTypes
{
	NSMutableArray *array = [NSMutableArray array];
	NSEnumerator *e = [editableTypes keyEnumerator];
	NSString *key;
	while (key = [e nextObject]) {
		[array addObjectsFromArray:[[editableTypes objectForKey:key] allObjects]];
	}
	
	e = [viewableTypes keyEnumerator];
	while(key = [e nextObject]){
		[array addObjectsFromArray:[[viewableTypes objectForKey:key] allObjects]];
	}
	return array;
}


- (BOOL)type:(NSString *)aType isContainedInDocType:(NSString*) key
{
	NSMutableSet *set = [editableTypes objectForKey:key];
	if(!set){
		set = [viewableTypes objectForKey:key];
		// That's wierd, someone has passed in an invalid type
		if(!set){
			NSLog(@"Invalid key passed to SeaDocumentController: <%@> \n Investigating type: <%@>", key, aType);
			return NO;
		}
	}
	
	NSEnumerator *e = [set objectEnumerator];
	NSString *candidate;
	while (candidate = [e nextObject]) {
		// I think we don't care about case in types
		if(![aType caseInsensitiveCompare:candidate]){
			return YES;
		}
	}
	return NO;
}

// Recent table view data source and delegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSArray *recentDocs = [super recentDocumentURLs];
    return [recentDocs count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cv = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    if ([cv isKindOfClass:[NSTableCellView class]])
    {
        NSArray *recentDocs = [super recentDocumentURLs];
        NSInteger i = row;
        if (recentDocs && i >= 0 && i < [recentDocs count])
        {
            NSString *path = [[recentDocs objectAtIndex:i] path];
            NSString *filename = [path lastPathComponent];
            NSImage *image = [[NSImage alloc] initWithContentsOfFile:path]; // [[NSWorkspace sharedWorkspace] iconForFile: path];
           
            cv.imageView.image = image;
            cv.textField.stringValue = filename;
            
            // tooltips
            cv.imageView.toolTip = path;
            cv.textField.toolTip = path;
            cv.toolTip = path;
        }
    }
    
    // return
    return cv;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSTableView *tableView = (NSTableView *)(notification.object);
    if ([tableView isKindOfClass:[NSTableView class]])
    {
        NSInteger i = tableView.selectedRow;
        NSArray *recentDocs = [super recentDocumentURLs];
        
        if (recentDocs && i >= 0 && i < [recentDocs count])
        {
            // Get the selected path.
            NSString *path = [[recentDocs objectAtIndex:i] path];
            
            // Deselect all
            [tableView performSelector:@selector(deselectAll:) withObject:self afterDelay:0.1];
            
            // Open it.
            [[NSDocumentController sharedDocumentController] openDocumentWithContentsOfFile:path display:YES];
        }
        
    }
}

@end
