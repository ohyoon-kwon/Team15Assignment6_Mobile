//
//  AddAdventurerViewController.swift
//  group15_assignment6
//
//  Created by Ohyoon Kwon on 15/10/2019.
//

import UIKit
import CoreData
import os.log

class AddAdventurerViewController: UIViewController, UITextFieldDelegate {
    var Adventurers: [NSManagedObject] = []

    //MARK: outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var savebtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        classTextField.delegate = self
        updateSaveButtonState()
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        savebtn.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text1 = nameTextField.text ?? ""
        let text2 = classTextField.text ?? ""
        savebtn.isEnabled = !text1.isEmpty && !text2.isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        print("end edit")
        print("\(savebtn.isEnabled)")
        nameTextField.resignFirstResponder()
        classTextField.resignFirstResponder()
    }
    
    // Mark : Navigation
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === savebtn else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }
}


