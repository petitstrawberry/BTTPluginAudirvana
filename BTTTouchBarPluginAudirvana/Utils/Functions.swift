//
//  Functions.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/18.
//

import Foundation
import MusicPlayer

func isRunningApp(name: String) -> Bool {
    var running = false
    let applications = NSWorkspace.shared.runningApplications
    
    for app in applications {
        if app.localizedName == name {
            running = true
            break
        }
    }
    return running
}

func isRunningApp(bundleIdentifier: String) -> Bool {
    var running = false
    let applications = NSWorkspace.shared.runningApplications
    
    for app in applications {
        if app.bundleIdentifier == bundleIdentifier {
            running = true
            break
        }
    }
    return running
}


func getPlayingPlayer(players: [MusicPlayers.Scriptable]) -> MusicPlayers.Scriptable? {
    var playingPlayer: MusicPlayers.Scriptable? = nil
    var score: Int = 0
    for player in players {
        var playerScore: Int = 0
        
        if !isRunningApp(bundleIdentifier: player.playerBundleID) {
            continue
        }
        
        if player.currentTrack != nil {
            playerScore+=1
        } else {
            continue
        }
        if player.playbackState != nil && player.playbackState.isPlaying {
            playerScore+=1
        }
        
        if score < playerScore {
            score = playerScore
            playingPlayer = player
        }
    }
    return playingPlayer
}
