
import UIKit

class TitleNewsCell: UITableViewCell {
    @IBOutlet weak var avaGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!

    func animateAvatar() {

        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 1
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        avaGroup.layer.add(animation, forKey: nil)
    }

    func clearNewsCell() {
        avaGroup.image = nil
        nameGroup.text = nil
    }

    override func prepareForReuse() {
        clearNewsCell()
    }

    func config (meNews: News){

        avaGroup.kf.setImage(with: URL(string: meNews.avaGroup))
        nameGroup.text = meNews.nameGroup
        avaGroup.layer.cornerRadius = 25
        animateAvatar()
          }

    override func awakeFromNib() {
        super.awakeFromNib()
        clearNewsCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

