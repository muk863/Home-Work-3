
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
import PromiseKit

final class NetworkFriends {
    
    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let id = Session.shared.userId
    private let pathForFriends = "method/friends.get"
    private var itemsRealm : Results<RealmFriend>!
    private var fotosRealm : Results<RealmFotos>!
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    private var idFriends = [FriendId]()
    
    func pingMyFriends() -> Promise<[FriendId]>{
        
        let (promise, resolver) = Promise<[FriendId]>.pending()
        
        let parametersListFriends: Parameters = [
            "user_id": id,
            "fields": "nickname,photo_200_orig",
            "order": "name",
            "access_token" : token,
            "v" : "5.131"
        ]
        AF.request(scheme + host + pathForFriends ,
                   method:.get,
                   parameters: parametersListFriends).responseJSON { [weak self] response in
            guard let self = self else {return}
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                guard let clearJson = JSON(rawValue: data) else {return}
                let items = clearJson["response"]["items"].arrayValue
                let countItems = items.count
                
                for i in 0 ..< countItems {
                    
                    let firstName = items[i]["first_name"].stringValue
                    let lastName = items[i]["last_name"].stringValue
                    let friendName = firstName + " " + lastName
                    let avatar = items[i]["photo_200_orig"].stringValue
                    let idFriend = items[i]["id"].stringValue
                    self.saveFriensToRealm(friendName: friendName, avatar: avatar, idFriend: idFriend)
                    let ids = FriendId(friendId: idFriend)
                    self.idFriends.append(ids)
                }
                resolver.fulfill(self.idFriends)
            }
        }
        return promise
    }
    
    func saveFriensToRealm (friendName name: String, avatar ava : String, idFriend : String){
        
        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let loadFriendsInRealm = RealmFriend(friendName: name, avatar: ava, idFriend : idFriend)
            realm.add(loadFriendsInRealm, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func  setupFriend() -> [Friend] {
        
        var itogArray = [Friend]()
        itemsRealm = realm.objects(RealmFriend.self)
        fotosRealm = realm.objects(RealmFotos.self)
        let count = itemsRealm.count
        
        for i in 0 ..< count {
            
            let name = itemsRealm[i].friendName
            let ava = itemsRealm[i].avatar
            let idFriend = itemsRealm[i].idFriend
            var arrayFriend = [String]()
            var likes = [String]()
            
            for j in 0 ..< fotosRealm.count{
                let fot = fotosRealm [j].allFotosOfFriend
                let like = fotosRealm[j].like
                
                if itemsRealm[i].idFriend == fotosRealm[j].idFriend {
                    arrayFriend.append(fot)
                    likes.append(like)
                }
            }
            
            let friend = Friend(nameFriend: name, avaFriend: ava, fotos: arrayFriend, like: likes, idFriend: idFriend)
            itogArray.append(friend)
        }
        return itogArray
    }
    
}

