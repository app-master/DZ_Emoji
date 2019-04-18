//
//  ListTableViewController.swift
//  DZ_Emoji
//
//  Created by user on 13/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var emojis: Emojis!
    
    var editingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojis = prepareEmojis()
        
        navigationItem.title = emojis.title
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellReuseIdentifier: "EmojiCell")
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if !editing {
            editingMode = !editingMode
        }
    }
    
    // MARK: - Methods
    
    private func prepareEmojis() -> Emojis {
        
        if let emojis = Emojis.loadEmojisFromDirectory(PlistManager.plistDirectory) {
            return emojis
        } else {
            let emojis = Emojis.createEmojis()
            emojis.writeEmojisToDirectory(PlistManager.plistDirectory)
            return emojis
        }
        
    }
    
}

// MARK: - Navigation

extension ListTableViewController {
    
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
    
// MARK: - Table view data source

extension ListTableViewController {
    
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .insert {
            
            let insertEmoji = emojis[indexPath.row]
            emojis.insert(insertEmoji, at: indexPath.row + 1)
            
            let newIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            tableView.beginUpdates()
            tableView.insertRows(at: [newIndexPath], with: .top)
            tableView.endUpdates()
            
            emojis.writeEmojisToDirectory(PlistManager.plistDirectory)
            
        } else if editingStyle == .delete {
            
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            emojis.writeEmojisToDirectory(PlistManager.plistDirectory)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == destinationIndexPath.section {
            emojis.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        }
        
    }
    
}
    
// MARK: - Table view data delegate

extension ListTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showAdditional", sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return editingMode ? .delete : .insert
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
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
        
        emojis.writeEmojisToDirectory(PlistManager.plistDirectory)

    }
    
}
