//
//  SystemMediaSeekBarView.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/10.
//

import SwiftUI
import MusicPlayer
import Sliders

struct SystemMediaSeekBarView: View {
    @State var geometry: GeometryProxy
    @EnvironmentObject var player: MusicPlayers.SystemMedia
    @State var position: Double = 0
    @State var sliderState: Bool = false
    var positionSec: Double {
        position * (player.currentTrack?.duration ?? 0)
    }
    let timer = Timer.publish(every: 1.0, on: .current, in: .common).autoconnect()
    
    var body: some View {
        
        HStack {
            Text(timeFormatter(sec: Int(positionSec)))
                .font(Font.caption.monospacedDigit())
            ValueSlider(value: $position, onEditingChanged: {flag in
                sliderState = flag
                if !flag {
                    player.playbackTime = position * (player.currentTrack?.duration ?? 1)
                }
            })
            .valueSliderStyle(
                HorizontalValueSliderStyle(
                    track: HorizontalValueTrack(
                        view: Color.blue.opacity(0.7),
                        mask: Rectangle())
                        .frame(height: 16, alignment: .center)
                        .background(Rectangle().foregroundColor(Color.secondary.opacity(0.4))),
                    thumbSize: CGSize(width: 0, height: 0),
                    thumbInteractiveSize: CGSize(width: 32, height: 32),
                    options: .interactiveTrack
                )
            )
            Text(timeFormatter(sec: Int((player.currentTrack?.duration ?? 0) - positionSec)))
                .font(Font.caption.monospacedDigit())
        }
        .padding()
        .onReceive(timer, perform: { _ in
            if !sliderState {
                player.updatePlayerState()
                position = player.playbackTime / ( player.currentTrack?.duration ?? 1)
            }
        }
        )
        
        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
        .clipped()
        
    }
    
    private func timeFormatter(sec: Int) -> String {
        
        let h = sec / 3600 % 24
        let m = sec / 60 % 60
        let s = sec % 60
        
        if h == 0 {
            return String(format: "%d:%02d", m, s)
        } else {
            return String(format: "%d:%d:%02d", h, m, s)
        }
    }
}
