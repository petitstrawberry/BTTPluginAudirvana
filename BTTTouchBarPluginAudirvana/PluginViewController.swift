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
        var widgetView: some View {
            
            Group {
                if !Configuration.shared.isSeekBarMode {
                    NowPlayingView()
                }else {
                    SeekBarView()
                }
            }
        }
        self.view = NSHostingView(
            rootView: widgetView
        )
        if !Configuration.shared.isSeekBarMode {
            self.view.setFrameSize(NSSize(width: 140, height: 30))
        }else {
            self.view.setFrameSize(NSSize(width: 440, height: 30))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
