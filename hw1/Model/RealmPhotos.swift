
import Foundation
import RealmSwift

final class RealmFotos: Object  {
    
    @objc dynamic var idFriend = String()
    @objc dynamic var allFotosOfFriend = String()
    @objc dynamic var idFoto = String()
    @objc dynamic var like = String()
    
    convenience init(idFriend : String, allFotosOfFriend : String, idFoto : String, like :String) {
        self.init()
        self.idFriend = idFriend
        self.allFotosOfFriend = allFotosOfFriend
        self.idFoto = idFoto
        self.like = like
        
    }
    
    override class func primaryKey() -> String? {
        return "idFoto"
    }
}
