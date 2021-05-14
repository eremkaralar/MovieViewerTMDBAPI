//
//  MovieCollectionViewCell.swift
//  MovieDemoAppTMDBAPI
//
//  Created by Erem Karalar on 4.05.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var MovieNameLabel: UILabel!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var image: UIImage? {
       didSet {
         ImageView.image = image
       }
     }
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    }
}

