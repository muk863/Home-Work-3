
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

final class NetworkFriendFotos {

    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let pathForFriendFoto = "method/photos.getAll"
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    private var itemsIdFriendsRealm : Results<RealmFriend>!


    func pingMyFriendFotos(idFriend : String) {

        let parametersListPhotosFriend : Parameters = [
            "owner_id": idFriend,
            "extended": "1",
            "no_service_albums": "0",
            "photo_sizes" : "0",
            "count" : "30",
            "access_token" : token,
            "v" : "5.131"
        ]

        AF.request(scheme + host + pathForFriendFoto ,
                   method: .get,
                   parameters: parametersListPhotosFriend).responseJSON { [weak self] response in
                    guard let self = self else {return}
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        guard let clearJsonFriendFotos = JSON(rawValue: data) else {return}
                        let items = clearJsonFriendFotos["response"]["items"].arrayValue
                        let countItemsFriendFotos = clearJsonFriendFotos["response"]["count"].intValue
                        let countFR = countItemsFriendFotos > 30 ? 30 : countItemsFriendFotos

                        for i in 0 ..< countFR {

                            let size = items[i]["sizes"].arrayValue
                            guard let url = size.last?["url"].stringValue else {return}
                            let idFoto = items[i]["id"].stringValue
                            let likeFoto = items[i]["likes"]["count"].stringValue
                            self.saveFriendFotoToRealm(idFriend: idFriend,
                                                       foto: url,
                                                       idFoto: idFoto,
                                                       like: likeFoto )
                        }
                    }
        }
    }


    func saveFriendFotoToRealm (idFriend : String, foto : String, idFoto : String, like : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let loadFotosInRealm = RealmFotos(idFriend: idFriend, allFotosOfFriend: foto, idFoto: idFoto, like: like)
            realm.add(loadFotosInRealm, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
