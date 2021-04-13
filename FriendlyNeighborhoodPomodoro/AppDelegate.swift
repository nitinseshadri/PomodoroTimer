//
//  AppDelegate.swift
//  FriendlyNeighborhoodPomodoro
//
//  Created by Nitin Seshadri on 4/9/21.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView().environmentObject(PomodoroTimerModel())

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 198, height: 195),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.level = .screenSaver
        window.titlebarAppearsTransparent = true
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if (flag) { // There are visible windows.
            if (window.isMiniaturized) {
                window.deminiaturize(nil)
            }
            return false
        } else { // There are no visible windows.
            window.makeKeyAndOrderFront(nil)
            return true
        }
    }

}

