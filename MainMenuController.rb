class MainMenuController < NSWindowController
	include Growl
	GROWL_HELLO = 'Hello'

	attr_accessor :menu

	def awakeFromNib
		Growl::Notifier.sharedInstance.register('GrowlSample', [GROWL_HELLO])
		growl GROWL_HELLO, 'OneBusAway Notifier', 'Ready to Serve', :icon => NSImage.imageNamed('onebusaway_icon')
			
		bar = NSStatusBar.systemStatusBar
		@item = bar.statusItemWithLength(NSSquareStatusItemLength)
		@item.image = NSImage.imageNamed('onebusaway_icon')
		@item.menu = @menu
	end
	
	def quit(sender)
		NSApplication.sharedApplication.terminate(sender)
	end
end
