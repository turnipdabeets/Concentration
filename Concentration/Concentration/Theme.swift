//
//  Theme.swift
//  Concentration
//
//  Created by Anna Garcia on 5/17/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import Foundation

class Theme
{
    enum Theme: UInt32 {
        case halloween
        case love
        case animal
        case waterCreatures
        case plants
        case weather
    }
    
    /// get an array of icons by theme
    func getThemeIcons(by theme: Theme) -> [String] {
        switch theme {
        case .halloween:
            return ["👻", "😈", "👹", "👺", "🎃", "☠️", "🦇", "💀"]
        case .love:
            return ["💕","💋", "💌", "💘", "❤️", "💓", "💖", "💔"]
        case .animal:
            return ["🐶", "🐒", "🐔", "🦊", "🦉", "🐭", "🐥", "🦎"]
        case .waterCreatures:
            return ["🦑", "🐙", "🐠", "🐡", "🐳", "🐚", "🦀", "🦈"]
        case .plants:
            return ["🍁", "🍄", "🌹", "💐", "🌾", "🌸", "🌺", "🌻"]
        case .weather:
            return ["🔥", "❄️", "☀️", "💦", "☔️", "🌬", "☁️", "🌪", "⛈"]
        }
    }
        
    private func random() -> Theme {
        let max = Theme.weather.rawValue
        let randomIndex = arc4random_uniform(max + UInt32(1))
        return Theme(rawValue: randomIndex) ?? Theme.halloween
    }
 
    /**
     get a random array of themed icons
     
     - Author:
     Anna
     */
    func getRandomThemeIcons() ->[String] {
        return getThemeIcons(by: random())
    }

}


