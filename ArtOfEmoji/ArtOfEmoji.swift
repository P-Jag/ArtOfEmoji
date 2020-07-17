//
//  ArtOfEmoji.swift
//  ArtOfEmoji
//
//  Created by Paweł Jagła on 16/07/2020.
//  Copyright © 2020 Paweł Jagła. All rights reserved.
//

import Foundation

struct ArtOfEmoji: Codable {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable, Hashable {
        let text: String
        let id: Int
        // 0,0 is a middle of screen
        var x: Int
        var y: Int
        var size: Int
        
        fileprivate init(text: String, id: Int, x: Int, y: Int, size: Int) {
            self.text = text
            self.id = id
            self.x = x
            self.y = y
            self.size = size
        }
    }
     
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
         if json != nil, let newArtOfEmoji = try? JSONDecoder().decode(ArtOfEmoji.self, from: json!) {
             self = newArtOfEmoji
         } else {
             return nil
         }
     }
    
    init() { }
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, id: uniqueEmojiId, x: x, y: y, size: size))
    }
}
