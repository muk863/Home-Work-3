
import UIKit
import Kingfisher

 class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width

            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        return CGSize(width: -1.0, height: -1.0)
    }

}

class ImageNewsCell: UITableViewCell{

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    func clearNewsCell() {
        imageNews.image = nil
    }

    override func prepareForReuse() {
        clearNewsCell()
    }

    func config (meNews: News){
        imageNews.kf.setImage(with: URL(string: meNews.imageNews))
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

