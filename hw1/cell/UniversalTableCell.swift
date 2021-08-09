//
//  UniversalTableCell.swift
//  hw1
//
//  Created by username on 27.06.2021.
//

import UIKit

class UniversalTableCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var saveObject: Any?
 
    func setup() {
        avatarImageView.layer.cornerRadius = 25
        backView.layer.cornerRadius = 25
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 5, height: 5)
        backView.layer.shadowRadius = 5
        backView.layer.shadowOpacity = 0.5
    }
    
    func clearCell() {
        self.avatarImageView.image = nil
        self.titleLabel.text = nil
        saveObject = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }

    func configure(title: String?, image: UIImage?) {
        titleLabel.text = title
        avatarImageView.image = image
    }
    
    func configure(user: User) {
        saveObject = user
        titleLabel.text = user.name
        avatarImageView.image = user.avatar
    }
    
    func configure(group: Group) {
        saveObject = group
        titleLabel.text = group.title
        avatarImageView.image = group.avatar
    }
    
    func animateAvatar() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 0.1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards

        self.backView.layer.add(animation, forKey: nil)
    }
    
    @IBAction func avatarButton(_ sender: Any) {
        animateAvatar()
        
        
    }
}
