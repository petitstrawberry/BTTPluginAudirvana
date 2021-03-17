//
//  ControllerView.swift
//  BTTTouchBarPluginAudirvanaLarge
//
//  Created by プチいちご on 2021/03/09.
//

import SwiftUI
import MusicPlayer
import Sliders

struct SeekBarView: View {
    @EnvironmentObject var player: MusicPlayers.Scriptable
    @EnvironmentObject var systemPlayer: MusicPlayers.Scriptable

    var body: some View {
        GeometryReader { geometry in
            if isSystemMediaPlaying() {
                SystemMediaSeekBarView(geometry: geometry)


            }else {
                AudirvanaSeekBarView(geometry: geometry)
            }

        }
    }

    func isSystemMediaPlaying() -> Bool {
        return player.playbackState == .stopped
    }
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        SeekBarView()
            .frame(width: 400, height: 30, alignment: .center)
    }
}
