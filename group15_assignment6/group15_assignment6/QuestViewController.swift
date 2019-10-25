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
        // Do any additional setup after loading the view.
        //timer = Timer.scheduledTimer(timeInterval: [time interval], target: self, selector: #selector([function to call]), userInfo: nil, repeats: true)
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
