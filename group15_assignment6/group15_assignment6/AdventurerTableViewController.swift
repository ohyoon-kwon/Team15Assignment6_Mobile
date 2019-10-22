//
//  AdventurerTableViewController.swift
//  group15_assignment6
//
//  Created by Ohyoon Kwon on 15/10/2019.
//

import UIKit
import CoreData

class AdventurerTableViewController: UITableViewController {
    
    // MARK: outlets
    @IBOutlet weak var addMember: UIBarButtonItem!

    var Adventurers: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // get sample data to display quest before add member working
        saveToCore(nameVal: "Ize",classVal: "Master Thief")
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Adventurers.count)
        return Adventurers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let adventurer = Adventurers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell",
                                          for: indexPath) as! MemberTableViewCell
        cell.portraitImage?.image = UIImage(named: "member2")
        cell.nameLabel?.text =
            adventurer.value(forKeyPath: "name") as? String
        cell.levelLabel?.text =
            adventurer.value(forKeyPath: "level") as? String
        cell.professionLabel?.text =
            adventurer.value(forKeyPath: "profession") as? String
        let att = adventurer.value(forKeyPath: "attackMod")
        cell.attackMod?.text = "\(att ?? 0)"
        let curHP = adventurer.value(forKeyPath: "currentHP")
        let totHP = adventurer.value(forKeyPath: "totalHP")
        cell.HPValLabel?.text = "\(curHP ?? 0)/\(totHP ?? 0)"
        return cell
    }
    
    // MARK: - action

    @IBAction func unwindToAdventurerView (sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddAdventurerViewController {
            let nameVal = sourceViewController.nameTextField.text ?? ""
            let photo = sourceViewController.photoImageView.image!
            let classVal = sourceViewController.classTextField.text ?? ""
            saveToCore(nameVal: nameVal,classVal: classVal/*,photo: photo*/)
        }

    }
    
    func saveToCore(nameVal:String,classVal:String/*,photo:UIImage*/) {
        
        let totalHP = Int16.random(in: 80..<130)
        let currentHP = totalHP
        let attackPoint : Float =  Float(Int.random(in: 100..<800)/100)

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
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
        member.setValue(totalHP, forKey: "totalHP")
        //member.setValue(photo, forKey: "portrait")
        
        // 4
        do {
            try managedContext.save()
            Adventurers.append(member)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
