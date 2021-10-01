
import UIKit

class TextNewsCell: UITableViewCell {
    @IBOutlet weak var textNews: UILabel!
    
    func clearNewsCell() {
        textNews.text = nil
    }

    override func prepareForReuse() {
        clearNewsCell()
    }

    func config (meNews: News){

        textNews.lineBreakMode = NSLineBreakMode.byWordWrapping
        textNews.numberOfLines = 0
        textNews.text = meNews.titleNews
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

