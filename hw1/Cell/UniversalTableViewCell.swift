
import UIKit
import Kingfisher
import RealmSwift

final class UniversalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var universalImage: UIImageView!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var universalTitleLabel: UILabel!

    private var cornerRadius : CGFloat = 25
    private var shadowOffset :CGSize = CGSize(width: 5, height: 5)
    private var shadowColor : UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    private var shadowRadius :CGFloat = 5
    private var shadowOpacity :Float = 0.5
    
    var saveObject : Any?
    let realm = try! Realm()
    var itemsRealm : Results<RealmFriend>!

    func setupCell(){
        
        backview.layer.cornerRadius = cornerRadius
        universalImage.layer.cornerRadius = cornerRadius
        backview.layer.shadowColor = shadowColor.cgColor
        backview.layer.shadowOffset = shadowOffset
        backview.layer.shadowRadius = shadowRadius
        backview.layer.shadowOpacity = shadowOpacity
        animateAvatar()
    }
    
    func clearCell(){
        self.universalImage.image = nil
        self.universalTitleLabel.text = nil
        self.saveObject = nil
    }
    
    func animateAvatar() {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 1
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        universalImage.layer.add(animation, forKey: nil)
        backview.layer.add(animation, forKey: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        clearCell()
    }

    func configureCell (user : Friend) {
        saveObject = user
        universalTitleLabel.text = user.nameFriend
        universalImage.kf.setImage(with: URL(string: user.avaFriend))
        animateAvatar()
    }
    
    func configureCell (group : Group) {
        saveObject = group
        universalTitleLabel.text = group.titleGroup
        universalImage.kf.setImage(with: URL(string: group.avaGroup))
        animateAvatar()
    }
    
}



