//
//  portraitCollectionViewCell.swift
//  group15_assignment6
//
//  Created by Xuxian Chen on 10/24/19.
//

import UIKit

class portraitCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var portraitImage: UIImageView!
    func displayContent(image:UIImage){
        portraitImage.image = image
    }
}
