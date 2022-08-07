//
//  userAPI.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/02.
//

import UIKit

public var accessToken = ""
public var refToken = ""

struct UserAPI: Codable {
    let memberId: Int
    let recordId: Int
    let brokenCounter: Int
    let maxConcentrationTime: Int
    let total_time: Int
    let timeStamp: String
}

struct Pram: Codable {
    let profileObj: ProfileObj1
}

struct ProfileObj1: Codable {
    var userToken: String
    var email: String
    var fullName: String
}


struct showMember: Codable {
    var userToken: String
    var email: String
    var fullName: String
    var memo: String  // null
    var numberOfFollowers : Int
}
