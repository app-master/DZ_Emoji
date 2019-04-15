//
//  ListTableViewController.swift
//  DZ_Emoji
//
//  Created by user on 13/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var emojis = Emojis.loadEmojis()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = emojis.title
        
        tableView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellReuseIdentifier: "EmojiCell")
    }
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiCell

        // Configure the cell...

        CellConfigurator.configureCell(cell, for: emojis[indexPath.row])
        
        return cell
    }
    
    // MARK: - Table view data delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showAdditional", sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAdditional" {
            let emojiTVC = segue.destination as! EmojiTableViewController
            emojiTVC.delegate = self
            
            guard let indexPath = tableView.indexPathForSelectedRow else {
            emojiTVC.navigationItem.title = "Добавить"
            return
            }
            emojiTVC.navigationItem.title = "Редактировать"
            let selectedEmoji = emojis[indexPath.row]
            emojiTVC.emoji = selectedEmoji
        }
        
    }
    
    @IBAction func addNewEmoji(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAdditional", sender: nil)
    }
    

}

extension ListTableViewController: EmojiTableViewControllerDelegate {
    
    func cancelEmoji() {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveEmoji(_ emoji: Emoji) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            emojis.append(emoji)
            let indexPath = IndexPath(row: emojis.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .fade)
        }

    }
    
}
