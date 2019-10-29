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
    
    var selectedPortrait: UIImage? = nil
    var currentLevel: String? = nil
    
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
        selectedPortrait = UIImage(named: portraitImageList[indexPath.row])!
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
    
}


