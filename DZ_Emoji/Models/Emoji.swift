//
//  Emoji.swift
//  DZ_Emoji
//
//  Created by user on 13/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

typealias Emojis = [Emoji]

class Emoji {
    
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    convenience init() {
        self.init(symbol: "", name: "", description: "", usage: "")
    }
    
}

extension Emojis {
    
    var title: String {
        return "Эмодзи"
    }
    
    static func loadEmojis() -> Emojis {
        
        return [Emoji(symbol: "😈", name: "Улыбающийся демон", description: "Демон который улыбается", usage: "Когда что то придумал(а) коварное"),
                Emoji(symbol: "🙂", name: "Легкая улыбка", description: "Слегка улыбающееся лицо", usage: "Когда не знаешь что ответить"),
                Emoji(symbol: "💩", name: "Веселая какашка", description: "Улыбающаяся какашка", usage: "По-приколу")]
    }
}

