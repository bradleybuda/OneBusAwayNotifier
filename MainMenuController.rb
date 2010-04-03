class MainMenuController < NSWindowController
	include Growl
	GROWL_HELLO = 'Hello'
	GROWL_BUS_IS_COMING = 'Bus is Coming'

	attr_accessor :menu

	def awakeFromNib
		# initial hello growl
		Growl::Notifier.sharedInstance.register('GrowlSample', [GROWL_HELLO, GROWL_BUS_IS_COMING])
		#growl GROWL_HELLO, 'OneBusAway Notifier', 'Checking for Buses...', :icon => NSImage.imageNamed('onebusaway_large')
		
		# start polling bus route
		Onebusaway.api_key = api_key
		self.performSelector('checkNextArrival', withObject: nil, afterDelay: 5);
		
		# add our icon to the status bar
		bar = NSStatusBar.systemStatusBar
		@item = bar.statusItemWithLength(NSSquareStatusItemLength)
		@item.image = NSImage.imageNamed('onebusaway_icon')
		@item.menu = @menu
	end
	
	def checkNextArrival
		arrivals = Onebusaway.arrivals_and_departures_for_stop(:id => '1_1610')
		my_arrival = arrivals.find { |a| a.routeId == '1_14' }
		if my_arrival.nil?
			growl GROWL_BUS_IS_COMING, 'OneBusAwayNotifier', "No upcoming arrivals for Route #14", :icon => NSImage.imageNamed('onebusaway_large')
		else
			growl GROWL_BUS_IS_COMING, 'OneBusAwayNotifier', "Route #14 is #{my_arrival.minutes_from_now} minutes away", :icon => NSImage.imageNamed('onebusaway_large')
		end
		self.performSelector('checkNextArrival', withObject: nil, afterDelay: 60);
	end
	
	def quit(sender)
		NSApplication.sharedApplication.terminate(sender)
	end
	
	def api_key
		# hey github - please don't steal my API key!  get yours at contact@onebusaway.org
		obfuscated = [14, 25, 163, 92, 222, 40, 91, 175, 26, 109, 95, 218, 121, 129, 61, 227, 138, 38, 164, 189, 163, 118, 138, 106, 28, 6, 206, 119, 84, 26, 94, 194, 203, 21, 163, 11, 231, 149, 66, 117, 67, 47, 247, 57, 8, 148, 116, 81, 29, 201, 137, 69, 97, 211, 58, 34, 54, 203, 182]
		srand(31337)
		obfuscated.map { |b| b ^ rand(256) }.pack('c*')
	end
end
