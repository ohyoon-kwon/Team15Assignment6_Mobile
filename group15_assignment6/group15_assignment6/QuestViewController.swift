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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleData()
        // Do any additional setup after loading the view.
        //timer = Timer.scheduledTimer(timeInterval: [time interval], target: self, selector: #selector([function to call]), userInfo: nil, repeats: true)
    }
    
    // MARK: Action
    @IBAction func endquest(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    func sampleData(){
        questDetailText.text = "Long story short"
        attackLabel.text = "3.33"
        nameLabel.text = "laz"
        hpLabel.text = "79/100"
        professionLabel.text = "Master Thief"
        portrait.image = UIImage(named:"member2")
        levelLabel.text = "1"
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
