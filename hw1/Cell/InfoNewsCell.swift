
import UIKit

class InfoNewsCell: UITableViewCell {

    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButtom: UIButton!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var repostCount: UILabel!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var dateNews: UILabel!

    func clearNewsCell() {
        likeCount.text = nil
        commentCount.text = nil
        repostCount.text = nil
        dateNews.text = nil
    }

    override func prepareForReuse() {
        clearNewsCell()
    }

    func config (meNews: News){

        likeCount.text = meNews.likeNews
        commentCount.text = meNews.commentNews
        repostCount.text = meNews.repostNews
        dateNews.text = meNews.dateNews
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clearNewsCell()
        likeButtom.imageView?.image = UIImage(systemName: "heart")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

