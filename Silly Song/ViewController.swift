//
//  ViewController.swift
//  Silly Song
//
//  Created by Tiago Rocha on 13/09/16.
//  Copyright © 2016 Tiago Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet weak var nameField: UITextField!
    //@IBOutlet weak var lyricsField: UITextView!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsField: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joinWithSeparator("\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.autocapitalizationType = .Words
        nameField.returnKeyType = .Done
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func reset(sender: AnyObject) {
        self.nameField.text = ""
        self.lyricsField.text = ""
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        if !(nameField.text == "") {
            nameField.text = nameField.text?.capitalizedString
            self.lyricsField.text = lyricsForName(bananaFanaTemplate, fullName: nameField.text!)
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
func shortNameFromName(fullName: String) -> String {
    let lowercaseName = fullName.lowercaseString
    let vowelSet = NSCharacterSet(charactersInString: "aeiou")
    
    if let firstVowelRange = fullName.rangeOfCharacterFromSet(vowelSet, options: .CaseInsensitiveSearch) {
        return lowercaseName.substringFromIndex(firstVowelRange.startIndex)
    }
    
    return lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    var finalLyrics = ""
    print(finalLyrics)
    finalLyrics = lyricsTemplate
        .stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
        .stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortNameFromName(fullName))
    
    return finalLyrics
}
