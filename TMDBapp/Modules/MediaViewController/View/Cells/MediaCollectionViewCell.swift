//
//  MediaCollectionViewCell.swift
//  TMDBapp
//
//  Created by 1 on 14.01.2022.
//

import UIKit
import SDWebImage

class ActorsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ActorsCollectionViewCell"
    
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
//    
//    private func setupUI() {
//        self.popularityLabel.textColor = .black
//    }
//    
//    func configureWith(popularityLabel: String?, imageURL: URL?) {
//        self.popularityLabel.text = popularityLabel
//        self.actorImageView.sd_setImage(with: imageURL, completed: nil)
//        setupUI()
//    }
}
