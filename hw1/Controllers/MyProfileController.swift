
import UIKit
import Kingfisher
import RealmSwift

final class MyProfileController: UIViewController {

    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myUserId: UILabel!
    @IBOutlet weak var myAvatar: UIImageView!
    @IBOutlet weak var myGallary: UICollectionView!

    private let avatar = String()
    private var myFotoArray = [String]()
    private let myFotoCellId = "myFotoCellId"
    private let countCells = 3
    private let offSetCell = 2

    override func viewDidLoad() {
        super.viewDidLoad()

        myGallary.dataSource = self
        myGallary.delegate = self
        myGallary.register(UINib(nibName: "MyFotoCollectionViewCell", bundle: nil),
                           forCellWithReuseIdentifier: myFotoCellId)
        setupMyProfile()
    }

    func  setupMyProfile()  {

        let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
        let itemsRealmMyProfile = realm.objects(RealmMyFoto.self)
        let count = itemsRealmMyProfile.count
        var myFotosLikes = [String]()

        for i in 0 ..< count {

            let myFoto = itemsRealmMyProfile[i].allMyFotos
            let like = itemsRealmMyProfile[i].like
            myFotoArray.append(myFoto)
            myFotosLikes.append(like)
        }
    }
}

extension MyProfileController : UICollectionViewDelegate,  UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myFotoArray.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myFotoCellId, for: indexPath) as? MyFotoCollectionViewCell else {return UICollectionViewCell()}
        cell.myFotoView.kf.setImage(with: URL(string: myFotoArray[indexPath.item]))
        return cell
    }
}

extension MyProfileController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let speacing = ((countCells + 1) * offSetCell) / countCells
        let widthCell = frameCV.width / CGFloat(countCells)-CGFloat(speacing)
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
}
