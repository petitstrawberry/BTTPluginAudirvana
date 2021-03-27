//
//  ViewExtension.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/16.
//  Copyright © 2021 Andreas Hegenberg. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func trigger(trigger: Any, action: @escaping () -> Void) -> some View {
        action()
        return self
    }
}
