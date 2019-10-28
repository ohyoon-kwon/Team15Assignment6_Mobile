//
//  AddAdventurerViewController.swift
//  group15_assignment6
//
//  Created by Ohyoon Kwon on 15/10/2019.
//

import UIKit
import CoreData
import os.log

class AddAdventurerViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    var Adventurers: [NSManagedObject] = []
    
    var portraitImageList = ["member1", "member2", "member3", "member4", "member5"]
    
    //MARK: outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
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
        //savebtn.isEnabled = false
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
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return portraitImageList.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! portraitCollectionViewCell
        
        // Configure the cell
        let portraitName = portraitImageList[indexPath.row]
        let portrait = UIImage(named: portraitName)!
        cell.displayContent(image: portrait)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.gray.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
        cell?.layer.borderColor = UIColor.clear.cgColor
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
    
    
    
    @IBAction func save(_ sender: UIButton) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Adventurer",
                                       in: managedContext)!
        
        let adventurer = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        let namefield = nameTextField.text
        let classfield = classTextField.text
        let selectedimage = UIImage(named: portraitImageList[0])!
        let imageData = selectedimage.pngData()
        
        // 3
        adventurer.setValue(namefield, forKeyPath: "name")
        adventurer.setValue(classfield, forKeyPath: "profession")
        adventurer.setValue(imageData, forKeyPath: "portrait")
    
        
        // 4
        do {
            try managedContext.save()
            Adventurers.append(adventurer)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
}


