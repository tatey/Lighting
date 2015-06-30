import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	var preferencesWindowController: PreferencesWindowController?

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		preferencesWindowController = PreferencesWindowController()
	}

	func applicationDidBecomeActive(notification: NSNotification) {
		preferencesWindowController?.window?.makeKeyAndOrderFront(self)
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		preferencesWindowController?.close()
		preferencesWindowController = nil
	}

	func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
		return true
	}
}
