//
//  QuestViewController.swift
//  group15_assignment6
//
//  Created by Ohyoon Kwon on 15/10/2019.
//

import UIKit
import CoreData

class QuestViewController: UIViewController {
    
    var timer: Timer?
    
    @IBOutlet weak var questDetailText: UITextView!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    
    var Adventurers: [NSManagedObject] = []
    var selectedCell: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //timer = Timer.scheduledTimer(timeInterval: [time interval], target: self, selector: #selector([function to call]), userInfo: nil, repeats: true)
        loadDataFromSelectedCell(selectedCell: selectedCell!)
    }
    
    // MARK: Action
    func loadDataFromSelectedCell(selectedCell : Int){
        print(Adventurers)
        let adventurer = Adventurers[selectedCell]
        portrait.image = UIImage(named: "member2")
        nameLabel.text = adventurer.value(forKeyPath: "name") as? String
        professionLabel.text = adventurer.value(forKeyPath: "profession") as? String
        let att = adventurer.value(forKeyPath: "attackMod")
        attackLabel.text = "\(att ?? 0)"
        let curHpAtSelect = adventurer.value(forKeyPath: "currentHP")
        let totHpAtSelect = adventurer.value(forKeyPath: "totalHP")
        levelLabel.text = adventurer.value(forKeyPath: "level") as? String
        hpLabel.text = "\(curHpAtSelect ?? 0)/\(totHpAtSelect ?? 0)"
    }
    @IBAction func endquest(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Adventurer")
        do {
            Adventurers = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
