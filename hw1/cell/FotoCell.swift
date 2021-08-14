//
//  FotoCell.swift
//  hw1
//
//  Created by username on 27.06.2021.
//

import UIKit

class FotoCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var fotoImageView: UIImageView!
    
    @IBOutlet weak var imageLikeView: UIImageView!
    @IBOutlet weak var likeLabelCount: UILabel!
    
    var currentCount = 8
    var isLiked = true
    
    func setup() {

    }
    
    func clearCell() {
        fotoImageView.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(image: UIImage) {
        fotoImageView.image = image
    }
    func configure(currentCount: Int) {
        imageLikeView.image = UIImage(systemName: "heart")
        likeLabelCount.text = String(currentCount)
        self.currentCount = currentCount
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
        pressLikeButton(AnyClass.self)
    }

    @IBAction func pressLikeButton(_ sender: Any) {
        if isLiked {
            imageLikeView.image = UIImage(systemName: "heart")
            currentCount -= 1
        }
        else {
            imageLikeView.image = UIImage(systemName: "heart.fill")
            currentCount += 1
        }
    
        likeLabelCount.text = String(currentCount)
        isLiked = !isLiked
        
        UIView.transition(with: likeLabelCount,
                          duration: 0.5,
                          options: .transitionFlipFromTop,
                          animations: { [self] in
                            self.likeLabelCount.text = likeLabelCount.text
                          },
                          completion: nil)
    }
}
