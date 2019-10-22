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
        nameTextField.resignFirstResponder()
        classTextField.resignFirstResponder()
    }

    @IBAction func savebtn(_ sender: UIButton) {
        //et nameVal = nameTextField.text!
        //let classVal = classTextField.text!
    }
    // This method lets you configure a view controller before it's presented.
    
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
        
        let nameVal = nameTextField.text ?? ""
        //let photo = photoImageView.image
        let classVal = classTextField.text
        let totalHP = Int.random(in: 80..<130)
        let currentHP = totalHP
        let attackPoint = Int.random(in: 100..<800) / 100
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)!
        
        let member = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        member.setValue(nameVal, forKeyPath: "name")
        member.setValue(1, forKeyPath: "level")
        member.setValue(classVal, forKey: "profession")
        member.setValue(attackPoint, forKey: "attackMod")
        member.setValue(currentHP, forKey: "currentHP")
        member.setValue(totalHP, forKey: "toalHP")
        
        // 4
        do {
            try managedContext.save()
            Adventurers.append(member)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


