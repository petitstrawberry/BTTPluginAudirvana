//
//  PluginViewController.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/05.
//

import Cocoa
import SwiftUI
import MusicPlayer

class PluginViewController: NSViewController {
    
    
    override func loadView() {
        var buttonView: some View {
            ButtonView()
                .environmentObject(MusicPlayers.Scriptable(name: .audirvana)!)
                .environmentObject(MusicPlayers.SystemMedia()!)
        }
        self.view = NSHostingView(
            rootView: buttonView
        )
        self.view.setFrameSize(NSSize(width: 140, height: 30))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
