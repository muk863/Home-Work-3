
import UIKit
import RealmSwift

struct News{
    var avaGroup : String
    var nameGroup : String
    var titleNews : String
    var imageNews : String
    var dateNews : String
    var likeNews : String
    var commentNews : String
    var repostNews : String
}

final class NewsModel {
    public var newsArray = [News]()
    private var news : Results<RealmNews>!
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))


    init() {
        setupNews()
    }

    func setupNews() {

        news = realm.objects(RealmNews.self)

        for i in 0 ..< news.count {

            let avaGroup = news[i].avaGroup
            let nameGroup = news[i].nameGroup
            let textNews = news[i].textNews
            let imageNews = news[i].imageNews
            let dateNews = news[i].dateNews
            let likeNews = news[i].likeNewsCount
            let commentNews = news[i].commentsNewsCount
            let repostNews = news[i].repostNewsCount
            let newNews = News(avaGroup : avaGroup, nameGroup: nameGroup, titleNews: textNews,
                               imageNews: imageNews, dateNews: dateNews, likeNews: likeNews,
                               commentNews: commentNews, repostNews: repostNews)
            newsArray.append(newNews)
        }
        
        



    }
}

