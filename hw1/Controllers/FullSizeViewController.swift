
import UIKit

final class FullSizeViewController: UIViewController {
    @IBOutlet weak var fullSizeViewCollection: UICollectionView!
    @IBOutlet var backViewFullScreen: UIView!
    
    private let FullSizeIdentifer = "FullSizeIdentifer"
    var friendsArray = [String]()
    var indexPath : IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullSizeViewCollection.delegate = self
        self.fullSizeViewCollection.dataSource = self
        fullSizeViewCollection.register(UINib(nibName: "FullSizeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FullSizeIdentifer)
        fullSizeViewCollection.performBatchUpdates(nil) { [self] result in
        fullSizeViewCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}

extension FullSizeViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendsArray.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullSizeIdentifer, for: indexPath) as? FullSizeCollectionViewCell else {return UICollectionViewCell()}
        cell.imageFullScreen.kf.setImage(with: URL(string: friendsArray[indexPath.item]))
        return cell
    }
}


extension FullSizeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
}
