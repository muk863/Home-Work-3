
import UIKit
import RealmSwift
import PromiseKit

final class MyTabBarController: UITabBarController {

    private let network = NetworkFriends()
    private let networkGroup = NetworkGroup()
    private let networkProfile = NetworkProfile()
    private let networkFriendFotos = NetworkFriendFotos()
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

    override func viewDidLoad() {
        super.viewDidLoad()

        network.pingMyFriends()
            .done { [weak self] idFriends in

                guard let self = self else {return}
                DispatchQueue.global(qos: .userInteractive).async {
                    for i in idFriends {
                        let idFriend = i.friendId
                        self.networkFriendFotos.pingMyFriendFotos(idFriend: idFriend)
                        usleep(450000)
                    }
                }
            }

        loadQueue()

        print("===\(realm.configuration.fileURL as Any)")
    }

    func loadQueue() {

        DispatchQueue.global(qos: .utility).async {
            self.networkGroup.pingMyGroups()
        }
        DispatchQueue.global(qos: .background).async {
            self.networkProfile.pingMyFotos()
        }
    }

}
