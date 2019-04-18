//
//  Emoji.swift
//  DZ_Emoji
//
//  Created by user on 13/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

typealias Emojis = [Emoji]

class Emoji: Codable {
    
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    var encoded: Data? {
        return try? PropertyListEncoder().encode(self)
    }
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    convenience init() {
        self.init(symbol: "", name: "", description: "", usage: "")
    }
    
    convenience init?(from data: Data) {
        guard let emoji = try? PropertyListDecoder().decode(Emoji.self, from: data) else { return nil }
        self.init(symbol: emoji.symbol, name: emoji.name, description: emoji.description, usage: emoji.usage)
    }
    
}

extension Emojis {
    
    var title: String {
        return "Эмодзи"
    }
    
    var encoded: Data? {
        return try? PropertyListEncoder().encode(self)
    }
    
    func writeEmojisToDirectory(_ directory: URL) {
        if let encoded = encoded {
            try? encoded.write(to: directory, options: .noFileProtection)
        }
    }
    
    static func loadEmojisFromDirectory(_ directory: URL) -> Emojis? {
        
        guard let emojisData = try? Data(contentsOf: directory) else { return nil }
        guard let emojis = try? PropertyListDecoder().decode(Emojis.self, from: emojisData) else { return nil }
        
        return emojis
        
    }
    
    static func createEmojis() -> Emojis {
        
        return [Emoji(symbol: "😈", name: "Улыбающийся демон", description: "Демон который улыбается", usage: "Когда что то придумал(а) коварное"),
                Emoji(symbol: "🙂", name: "Легкая улыбка", description: "Слегка улыбающееся лицо", usage: "Когда не знаешь что ответить"),
                Emoji(symbol: "💩", name: "Веселая какашка", description: "Улыбающаяся какашка", usage: "По-приколу")]
    }
    
}

