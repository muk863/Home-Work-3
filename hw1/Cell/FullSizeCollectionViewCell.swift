
import UIKit

class FullSizeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageFullScreen: UIImageView!

    func setupCell(){

    }
   
    func clearCell() {
        imageFullScreen.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func config (image: UIImage){

        imageFullScreen.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCell()
       clearCell()
    }
    
}
