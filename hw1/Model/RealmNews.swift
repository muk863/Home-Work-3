
import Foundation
import RealmSwift

final class RealmNews: Object  {

    @objc dynamic var idGroup = String()
    @objc dynamic var nameGroup = String()
    @objc dynamic var avaGroup = String()
    @objc dynamic var textNews = String()
    @objc dynamic var imageNews = String()
    @objc dynamic var dateNews = String()
    @objc dynamic var likeNewsCount = String()
    @objc dynamic var commentsNewsCount = String()
    @objc dynamic var repostNewsCount = String()


    convenience init(idGroup : String, nameGroup : String, avaGroup : String, textNews : String, imageNews : String,
                     dateNews : String, likeNewsCount : String,
                     commentsNewsCount : String, repostNewsCount : String) {
        self.init()
        self.idGroup = idGroup
        self.nameGroup = nameGroup
        self.avaGroup = avaGroup
        self.textNews = textNews
        self.imageNews = imageNews
        self.dateNews = dateNews
        self.likeNewsCount = likeNewsCount
        self.commentsNewsCount = commentsNewsCount
        self.repostNewsCount = repostNewsCount

    }
}
