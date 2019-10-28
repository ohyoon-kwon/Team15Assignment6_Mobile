//
//  QuestViewController.swift
//  group15_assignment6
//
//  Created by Ohyoon Kwon on 15/10/2019.
//

import UIKit
import CoreData

class QuestViewController: UIViewController {
    
    @IBOutlet weak var questDetailText: UITextView!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var curLabel: UILabel!
    @IBOutlet weak var totLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    
    var timer: Timer?
    var Adventurers: [NSManagedObject] = []
    var adventurerID : Int?
    var turn = 0;
    var enemyHP = 0;
    var monstersSlayed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 /*       let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(questTurn), userInfo: nil, repeats: true)*/
    }
    
    // MARK: Action
    @IBAction func endquest(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    func getAdventurer(ID : Int){
        let adventurer = Adventurers[ID]
        print(adventurer)
        if let imageData = adventurer.value(forKey: "portrait") as? Data {
            portrait?.image = UIImage(data: imageData)}
        nameLabel.text = adventurer.value(forKeyPath: "name") as? String
        levelLabel.text = adventurer.value(forKeyPath: "level") as? String
        professionLabel.text = adventurer.value(forKeyPath: "profession") as? String
        /*attackLabel.text = adventurer.value(forKeyPath: "attackMod")! as? String
        totLabel.text = adventurer.value(forKeyPath: "totalHP")! as? String
        curLabel.text = totLabel.text*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Adventurer")
        //3
        do {
            Adventurers = try managedContext.fetch(fetchRequest)
            getAdventurer(ID: adventurerID!)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
   /*
    @objc func questTurn() {
        // Set enemy
        if (enemyHP <= 0) {
            enemyHP = Int(arc4random_uniform(50)) + 100;
            //enemyHP = 20;
            if (turn != 0) {questDetailText.text += "\nEnemy is defeated!\nA new enemy appears!"; monstersSlayed += 1;}
        }
        // Adventurer makes move
        let attack = (Int(arc4random_uniform(6)) != 0);
        if (turn % 2 == 0) {
            if (attack) {
                // Access MEMBER_ATTACK and use it as a multplier.
                var temp = (attackLabel.text! as NSString).doubleValue;
                temp = round(temp * 15);
                let damage = Int(temp) + Int(arc4random_uniform(10)) + 10;
                enemyHP -= Int(damage);
                // Access MEMBER_NAME to print to log
                questDetailText.text += "\n\(nameLabel.text ?? "") attacks for \(damage)";
            }
            else {questDetailText.text += "\n\(nameLabel.text ?? "") is waiting...";}
        }
            // Monster makes move
        else {
            if (attack) {
                let damage = Int(arc4random_uniform(10)) + 5;
                //let damage = 1
                // subtact from MEMBER_HP
                let hp = (curLabel.text! as NSString).intValue
                curLabel.text = String(hp - Int32(damage))
                questDetailText.text += "\nMonster attacks for \(damage)"
                
            }
            else {questDetailText.text += "\nThe monster is waiting...";}
        }
        turn += 1;
        // Close window if  MEMBER_HP falls to zero:
        if ((curLabel.text! as NSString).intValue <= 0) {
            dismiss(animated: true, completion: nil)
            
        }
        if (monstersSlayed == 3) {
            let level = (levelLabel.text! as NSString).intValue;
            levelLabel.text = String(level + 1);
            monstersSlayed = 0;
        }
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
