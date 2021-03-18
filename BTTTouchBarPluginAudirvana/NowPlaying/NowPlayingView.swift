//
//  NowPlayingView.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/05.
//

import SwiftUI
import MusicPlayer

struct NowPlayingView: View {
    @ObservedObject var audirvana = MusicPlayers.Scriptable(name: .audirvana)!
    @ObservedObject var spotify = MusicPlayers.Scriptable(name: .spotify)!
    @ObservedObject var appleMusic = MusicPlayers.Scriptable(name: .appleMusic)!
    @ObservedObject var systemPlayer = MusicPlayers.SystemMedia()!
    
    var body: some View {
        GeometryReader { geometry in
            if !isAudirvanaPlaying() {
                let player = getPlayingPlayer(players: [spotify, appleMusic])
                
                if player?.name == .spotify {
                    SpotifyView(geometry: geometry)
                }else if player?.name == .appleMusic {
                    AppleMusicView(geometry: geometry)
                }else if Configuration.shared.isSystemMediaMode {
                    SystemMediaView(geometry: geometry)
                }else {
                    AudirvanaView(geometry: geometry)
                }
            }else {
                AudirvanaView(geometry: geometry)
            }
            
        }
        .cornerRadius(6.0)
    }
    
    func isAudirvanaPlaying() -> Bool {
        if !isRunningApp(name: "Audirvana") {
            return false
        }
        return !(audirvana.playbackState == .stopped)// && otherPlayer.currentTrack != nil)
    }
    
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}


