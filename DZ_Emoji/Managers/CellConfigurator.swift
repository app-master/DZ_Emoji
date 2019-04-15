//
//  CellConfigurator.swift
//  DZ_Emoji
//
//  Created by user on 14/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

class CellConfigurator {
    
    static func configureCell(_ cell: EmojiCell, for emoji: Emoji) {
        
        cell.symbolLabel.text = emoji.symbol
        cell.nameLabel.text = emoji.name
        cell.descriptionLabel.text = emoji.description
        
    }
    
}
