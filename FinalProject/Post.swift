//
//  Post.swift
//  FinalProject
//
//  Created by Owen Okst on 4/28/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum YourHouse: String, CaseIterable, Codable {
    case Gryffindor, Slytherin, Hufflepuff, Ravenclaw
}

struct Post: Codable, Identifiable {
    @DocumentID var id: String?
    var title = ""
    var body = ""
    var movie = ""
    var character = ""
    var house = YourHouse.Gryffindor.rawValue
    var poster = Auth.auth().currentUser?.email ?? ""
    var date = Date()
    
    var dictionary: [String: Any] {
        return["title": title, "body": body, "movie": movie, "character": character, "house": house, "poster": poster, "date": Timestamp(date: Date())]
    }
}
