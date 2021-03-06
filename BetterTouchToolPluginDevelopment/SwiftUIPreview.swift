//
//  SwiftUIPreview.swift
//  BetterTouchToolPluginDevelopment
//
//  Created by プチいちご on 2021/03/06.
//  Copyright © 2021 Andreas Hegenberg. All rights reserved.
//

import SwiftUI
import MusicPlayer

struct SwiftUIPreview: View {
    var body: some View {
        
        ButtonView().environmentObject(MusicPlayers.Scriptable(name: .audirvana)!)
            
            
    }
}

struct SwiftUIPreview_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIPreview()
            .frame(width: 140, height: 30, alignment: .bottom)
    }
}
