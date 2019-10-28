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
    var turn = 0;
    var enemyHP = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(questTurn), userInfo: nil, repeats: true)
    }
    
    @objc func questTurn() {
        // Set enemy
        if (enemyHP <= 0) {
            enemyHP = Int(arc4random_uniform(50)) + 100;
            if (turn != 0) {questDetailText.text += "\nEnemy is defeated!\nA new enemy appears!"}
        }
        // Adventurer makes move
        let attack = (Int(arc4random_uniform(4)) != 0);
        if (turn % 2 == 0) {
            if (attack) {
                // Access MEMBER_ATTACK and use it as a multplier.
                var temp = (attackLabel.text! as NSString).doubleValue;
                temp = round(temp * 15);
                let damage = Int(temp) + Int(arc4random_uniform(10));
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
                // subtact from MEMBER_HP
                questDetailText.text += "\nMonster attacks for \(damage)"
                
            }
            else {questDetailText.text += "\nThe monster is waiting...";}
        }
        turn += 1;
        // Close window if  MEMBER_HP falls to zero:
        // if ((attackLabel.text! as NSString).intValue <= 0) {dismiss(animated: true, completion: nil)}
    }
    
    // MARK: Action
    @IBAction func endquest(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

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
