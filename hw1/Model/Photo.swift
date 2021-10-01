//
//  Photo.swift
//  hw1
//
//  Created by username on 02.09.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

class FriendsPhotoResponse: Decodable {
    let response: FriendsPhotoItems
}

class FriendsPhotoItems: Decodable {
    let items: [UserPhoto]
    let count: Int?
}

class UserPhoto: RealmSwift.Object, Decodable {
    //    var album_id: Int
    //    var date: Int
    //    var has_tags: Int
    // @objc dynamic var id: Int
    @objc dynamic var owner_id: Int
    //   @objc dynamic var user_id: Int
    @objc dynamic var photo_604: String
    //var post_id: Int
    //var text: String
    override static func primaryKey() -> String? { //Ставим первичный ключ
        return "photo_604"
    }
}
