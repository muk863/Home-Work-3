
import Foundation
import RealmSwift

final class RealmGroup: Object  {

    @objc dynamic var idGroup = String()
    @objc dynamic var titleGroup = String()
    @objc dynamic var avaGroup = String()
   

    convenience init(idGroup : String, titleGroup : String, avaGroup : String) {
        self.init()
        self.idGroup = idGroup
        self.titleGroup = titleGroup
        self.avaGroup = avaGroup

    }

override class func primaryKey () -> String?{
    return "idGroup"
}
}
