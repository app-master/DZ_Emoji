//
//  EmojiTableViewController.swift
//  DZ_Emoji
//
//  Created by user on 13/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

protocol EmojiTableViewControllerDelegate: class {
   func cancelEmoji()
   func saveEmoji(_ emoji: Emoji)
}

class EmojiTableViewController: UITableViewController {

    weak var delegate: EmojiTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        print(#function)
        delegate?.cancelEmoji()
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
         print(#function)
        delegate?.saveEmoji(Emoji())
        self.navigationController?.popViewController(animated: true)
    }
    
}
