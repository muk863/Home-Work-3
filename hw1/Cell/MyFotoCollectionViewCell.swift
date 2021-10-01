
import UIKit

class MyFotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myFotoView: UIImageView!

    func setupCell(){

    }

    func clearCell() {

        myFotoView.image = nil
    }


    override func prepareForReuse() {
        clearCell()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
        setupCell()
    }

}
