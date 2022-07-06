//
//  userAPI.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/02.
//

import UIKit

struct UserAPI: Codable {
    let memberId: Int
    let recordId: Int
    let brokenCounter: Int
    let maxConcentrationTime: Int
    let total_time: Int
    let timeStamp: String
}
