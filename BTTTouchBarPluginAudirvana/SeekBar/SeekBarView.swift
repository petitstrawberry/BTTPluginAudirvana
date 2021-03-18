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
    @ObservedObject var audirvana = MusicPlayers.Scriptable(name: .audirvana)!
    @ObservedObject var spotify = MusicPlayers.Scriptable(name: .spotify)!
    @ObservedObject var appleMusic = MusicPlayers.Scriptable(name: .appleMusic)!
    @ObservedObject var systemPlayer = MusicPlayers.SystemMedia()!
    
    var body: some View {
        GeometryReader { geometry in
            if !isAudirvanaPlaying() {
                let player = getPlayingPlayer(players: [spotify, appleMusic])
                
                if  player?.name == .spotify {
                    SpotifySeekBarView(geometry: geometry)
                }else if player?.name == .appleMusic {
                    AppleMusicSeekBarView(geometry: geometry)
                }else if Configuration.shared.isSystemMediaMode {
                    SystemMediaSeekBarView(geometry: geometry)
                }else {
                    AudirvanaSeekBarView(geometry: geometry)
                }
            }else {
                AudirvanaSeekBarView(geometry: geometry)
            }
        }.background(Color.clear)
    }
    
    func isAudirvanaPlaying() -> Bool {
        if !isRunningApp(name: "Audirvana") {
            return false
        }
        return !(audirvana.playbackState == .stopped)
    }
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        SeekBarView()
            .frame(width: 400, height: 30, alignment: .center)
    }
}
