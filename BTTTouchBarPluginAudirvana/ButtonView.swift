//
//  ButtonView.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/05.
//

import SwiftUI
import MusicPlayer

struct ButtonView: View {
    @EnvironmentObject var player: MusicPlayers.Scriptable
    @EnvironmentObject var systemPlayer: MusicPlayers.SystemMedia
    
    var body: some View {
        GeometryReader { geometry in
            if isSystemMediaPlaying() {
                SystemMediaView(geometry: geometry)
                    
                    
            }else {
                AudirvanaView(geometry: geometry)
            }
            
        }
        .cornerRadius(6.0)
        //.border(Color.red, width: 1)
    }
        
    func isSystemMediaPlaying() -> Bool {
        return player.playbackState == .stopped && systemPlayer.currentTrack != nil
    }

    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}


