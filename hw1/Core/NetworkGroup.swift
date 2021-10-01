
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

final class NetworkGroup {

    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let id = Session.shared.userId
    private let pathForGroup = "method/groups.get"

    func pingMyGroups(){

        let parametersListGroups: Parameters = [
            "user_id": id,
            "extended" : "1",
            "access_token" : token,
            "v" : "5.131" ]
        AF.request(scheme + host + pathForGroup ,
                   method:.get,
                   parameters: parametersListGroups).responseJSON { [weak self] response in
                    guard let self = self else {return}
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):

                        guard let clearJson = JSON(rawValue: data) else {return}
                        let items = clearJson["response"]["items"].arrayValue
                        let countItems = clearJson["response"]["count"].intValue

                        for i in 0 ..< countItems {
                            let id = items[i]["id"].stringValue
                            let myGroupName = items[i]["name"].stringValue
                            let myGroupAvatar = items[i]["photo_200"].stringValue
                            self.saveGroupsToRealm(idGroup: id, groupName: myGroupName, avatar: myGroupAvatar)
                        }
                    }
                   }
    }

    func saveGroupsToRealm (idGroup id : String, groupName name: String, avatar ava : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let loadGroupsInRealm = RealmGroup(idGroup: id, titleGroup: name, avaGroup: ava)
            realm.add(loadGroupsInRealm, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
