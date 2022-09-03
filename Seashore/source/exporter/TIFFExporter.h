#import "Globals.h"
#import "AbstractExporter.h"

/*!
	@class		TIFFExporter
	@abstract	Exports to the tagged image file format using Cocoa.
	@discussion	N/A
				<br><br>
				<b>License:</b> GNU General Public License<br>
				<b>Copyright:</b> Copyright (c) 2002 Mark Pazolli
*/

@interface TIFFExporter : AbstractExporter {
	
	// The associated document
	__weak IBOutlet id idocument;
	
	// The panel allowing colour space choice
	IBOutlet NSWindow * panel;
	
	// The radio buttons specifying the target
	IBOutlet id targetRadios;

}

/*!
	@method		init
	@discussion	Initializes an instance of this class.
	@result		Returns instance upon success (or NULL otherwise).
*/
- (id)init;

/*!
	@method		targetChanged:
	@discussion	Called when the user adjusts the media target.
	@param		sender
				Ignored.
*/
- (IBAction)targetChanged:(id)sender;

/*!
	@method		endPanel:
	@discussion	Called to close the options dialog.
	@param		sender
				Ignored.
*/
- (IBAction)endPanel:(id)sender;

@end
