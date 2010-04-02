class MainMenuController < NSWindowController
	attr_accessor :menu

	def awakeFromNib
		bar = NSStatusBar.systemStatusBar
		@item = bar.statusItemWithLength(NSSquareStatusItemLength)
		@item.image = NSImage.imageNamed('onebusaway_icon')
		@item.menu = @menu
	end
	
	def quit(sender)
		NSApplication.sharedApplication.terminate(sender)
	end
end
