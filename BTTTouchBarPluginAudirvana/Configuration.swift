//
//  Configuration.swift
//  BTTTouchBarPluginAudirvana
//
//  Created by プチいちご on 2021/03/10.
//

class Configuration {
    static let shared = Configuration()
    private init() {}
    
    public var isSeekBarMode: Bool = false
    public var isSystemMediaMode: Bool = false
}
