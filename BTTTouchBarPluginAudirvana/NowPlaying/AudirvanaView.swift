//
//  AudirvanaView.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/06.
//

import SwiftUI
import MusicPlayer

struct AudirvanaView: View {
    @State var geometry: GeometryProxy
    @EnvironmentObject var player: MusicPlayers.Scriptable
    
    @State var backgroundColor: NSColor = .controlColor
    
    func openAudirvana() -> Bool {
        return NSWorkspace.shared.launchApplication("Audirvana")
    }
    
    @State var tapBeginTime: Date = Date()
    @State var isTap: Bool = false
    
    var gesture: some Gesture {
        DragGesture(minimumDistance: 0.0)
            .onChanged(){ value in
                if !isTap {
                    tapBeginTime = value.time
                }
                isTap = true
                backgroundColor = .gray
//                let passedTime = value.time.timeIntervalSince(tapBeginTime)
//
//                // Long press
//                if passedTime > 0.8 && abs(value.translation.width) < 5 &&  NSWorkspace.shared.frontmostApplication?.localizedName != "Audirvana" {
//                    backgroundColor = .controlColor
//                    isTap = false
//                    openAudirvana()
//                }
            }
            .onEnded(){ value in
                let passedTime = value.time.timeIntervalSince(tapBeginTime)
                print(passedTime)
                if passedTime <= 0.8 && abs(value.translation.width) < 10 {
                    tappedButton()
                } else {
                    backgroundColor = .controlColor
                }
                if value.translation.width <= -10 {
                    player.skipToNextItem()
                    print("Next")
                }else if value.translation.width >= 10{
                    player.skipToPreviousItem()
                    print("Previous")
                }
                isTap = false
            }
    }
    
    func tappedButton() {
        backgroundColor = .controlColor
        if player.playbackState == .stopped && player.currentTrack?.title != "" {
            print(openAudirvana())
        }else {
            player.playPause()
        }
    }
    
    var body: some View {
        HStack {
            
            if player.currentTrack?.artwork != nil {
                Image(nsImage: (player.currentTrack?.artwork)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .cornerRadius(2.0)
                    .clipped()
            }else {
                Image(systemName: "music.note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .cornerRadius(2.0)
                    .clipped()
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                if player.playbackState != .stopped {
                    Text(player.currentTrack?.title ?? "Unknown")
                        .font(Font.custom("TitleText", size: 10))
                        .fontWeight(.thin)
                        .frame(height: 12)
                }else if player.currentTrack?.title != "" {
                    Text("Audirvanaを開く")
                        .font(Font.custom("TitleText", size: 10))
                        .frame(height: 20)
                }else {
                    Text("何も再生してないよ")
                        .font(Font.custom("TitleText", size: 10))
                        .frame(height: 20)
                }
                if player.playbackState != .stopped {
                    if player.currentTrack?.artist != nil {
                        Text((player.currentTrack?.artist)!)
                            .font(Font.custom("ArtistText", size: 8))
                            .frame(height: 8)
                    }
                }
            }
            .frame(height: 20)
            Spacer()
        }
        .padding(.horizontal, 6.0)
        .frame(width: geometry.size.width, height: geometry.size.height
               , alignment: .center)
        .background(Color.init(backgroundColor))
        .gesture(gesture)
        
    }
}
