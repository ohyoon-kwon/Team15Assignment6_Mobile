//
//  MemberTableViewCell.swift
//  group15_assignment6
//
//  Created by Colton R on 10/20/19.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var portraitImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var attackMod: UILabel!
    @IBOutlet weak var HPValLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
