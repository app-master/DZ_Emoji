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

    @IBOutlet weak var symbolField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var usageField: UITextField!
    
    @IBOutlet weak var saveButtonItem: UIBarButtonItem!
    
    var emoji: Emoji?
    
    weak var delegate: EmojiTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
        updateUI()
    }
    
    private func setupUI() {
        symbolField.text = emoji?.symbol ?? ""
        nameField.text = emoji?.name ?? ""
        descriptionField.text = emoji?.description ?? ""
        usageField.text = emoji?.usage ?? ""
    }
    
    private func updateUI() {
        saveButtonItem.isEnabled = !symbolField.text!.isEmpty &&
            !nameField.text!.isEmpty &&
            !descriptionField.text!.isEmpty &&
            !usageField.text!.isEmpty
    }
    
    private func saveEmoji() {
        
        if emoji == nil {
            emoji = Emoji()
        }
        
        emoji?.symbol = symbolField.text ?? ""
        emoji?.name = nameField.text ?? ""
        emoji?.description = descriptionField.text ?? ""
        emoji?.usage = usageField.text ?? ""
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.cancelEmoji()
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        saveEmoji()
        
        delegate?.saveEmoji(emoji!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionTextChanged(_ sender: UITextField) {
        updateUI()
    }
    
}

extension EmojiTableViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        switch textField {
            
            case symbolField:
                
                if range.location > 0 {
                    return false
                }

            default:
                break
            
       }
        
       return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case symbolField: nameField.becomeFirstResponder()
        case nameField: descriptionField.becomeFirstResponder()
        case descriptionField: usageField.becomeFirstResponder()
        case usageField: usageField.resignFirstResponder()
        default:
            break
        }
        
        return true
        
    }
    
}
