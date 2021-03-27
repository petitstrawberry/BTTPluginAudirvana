//
//  SystemMediaView.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/06.
//

import SwiftUI
import MusicPlayer

struct SystemMediaView: View {
    @State var geometry: GeometryProxy
    @ObservedObject var player = MusicPlayers.SystemMedia()!

    @State var backgroundColor: NSColor = .controlColor

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
            }
            .onEnded(){ value in
                let passedTime = value.time.timeIntervalSince(tapBeginTime)
                print(passedTime)
                if passedTime <= 0.8 && abs(value.translation.width) < 10 {
                    tappedButton()
                } else{
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
        player.playPause()
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
                    //Text(player.playbackState.description)
                    Text(player.currentTrack?.title ?? "Unknown")
                        .font(Font.custom("TitleText", size: 10))
                        .frame(height: 12)
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
