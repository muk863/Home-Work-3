
import Foundation
import RealmSwift

final class RealmMyFoto: Object  {

    @objc dynamic var allMyFotos = String()
    @objc dynamic var idFoto = String()
    @objc dynamic var like = String()


    convenience init(idFoto : String, allMyFotos : String, like :String) {
        self.init()
        self.idFoto = idFoto
        self.allMyFotos = allMyFotos
        self.like = like
    }

    override class func primaryKey() -> String? {
        return "idFoto"
    }
}
