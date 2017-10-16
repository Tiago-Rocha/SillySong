//
//  ViewController.swift
//  Silly Song
//
//  Created by Tiago Rocha on 13/09/16.
//  Copyright © 2016 Tiago Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsField: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.autocapitalizationType = .words
        nameField.returnKeyType = .done
    }
    @IBAction func reset(_ sender: AnyObject) {
        self.nameField.text = ""
        self.lyricsField.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: AnyObject) {
        if !(nameField.text == "") {
            nameField.text = nameField.text?.capitalized
            self.lyricsField.text = lyricsForName(bananaFanaTemplate, fullName: nameField.text!)
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
func shortNameFromName(_ fullName: String) -> String {
    let lowercaseName = fullName.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    
    if let firstVowelRange = lowercaseName.rangeOfCharacter(from: vowelSet, options: .caseInsensitive) {
        return lowercaseName.substring(from: firstVowelRange.lowerBound)
    }
    
    return lowercaseName
}

func lyricsForName(_ lyricsTemplate: String, fullName: String) -> String {
    var finalLyrics = ""
    print(finalLyrics)
    finalLyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(fullName))
    
    return finalLyrics
}
