//
//  API Caller.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/02.
//
import UIKit

func getUserAPI(user: String) -> UserAPI {
    let userURL = "balblabla/\(user)"
    var outValue = UserAPI(memberId: -9, recordId: 9, brokenCounter: -9, maxConcentrationTime: -9, total_time: -9, timeStamp: "0")
    var run = true
    
    guard let url = URL(string: userURL) else {
        fatalError("Invalid URL")
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error { // 에러가 발생함
            print(error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        
        guard let data = data else { // 데이터 동기화 안될경우 오류 발생
            fatalError("Invalid Data")
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            outValue = try decoder.decode(UserAPI.self, from: data)
            run = false
        } catch {
            print(error)
        }
    }
    task.resume()
    
    while run {
    }
    
    return outValue
}
