//
//  FollwerDataModel.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/29.
//

import Foundation

class FollwerDataModel {
    
    public var arrayStruct: [follwerInfo] = [
        follwerInfo(image: "IMG_0518.jpg", numberOfFollower: 13, focusTimeForThisMonth: 23, followeName: "Jason", follwerDesciption: "1번타자", todayFocusTime: 49, brokenCount: 5),
        follwerInfo(image: "IMG_1394.JPG", numberOfFollower: 29, focusTimeForThisMonth: 92, followeName: "Mason", follwerDesciption: "2번타자", todayFocusTime: 23, brokenCount: 3),
        follwerInfo(image: "IMG_1482.jpg", numberOfFollower: 13, focusTimeForThisMonth: 29, followeName: "Kason", follwerDesciption: "3번타자", todayFocusTime: 82, brokenCount: 2)
   ]
    
    public func inputData(image:String, numberOfFollower:Int, focusTimeForThisMonth:Int, followeName:String, follwerDesciption:String, todayFocusTime:Int, brokenCount:Int) {
        self.arrayStruct.append(follwerInfo(image: image, numberOfFollower: numberOfFollower, focusTimeForThisMonth: focusTimeForThisMonth, followeName: followeName, follwerDesciption: follwerDesciption, todayFocusTime: todayFocusTime, brokenCount: brokenCount))
    }

    public func removeFromDataModel(index:Int) {
        self.arrayStruct.remove(at: index)
    }
    
    public var count: Int {
        return arrayStruct.count
    }
    
    public func getImage(index: Int) -> String {
        return arrayStruct[index].image ?? ""
    }
    
    public func getNumberOfFollower(index: Int) -> Int {
        return arrayStruct[index].numberOfFollower ?? 0
    }
    
    public func getFocusTimeForThisMonth(index: Int) -> Int {
        return arrayStruct[index].focusTimeForThisMonth ?? 0
    }
    
    public func getFolloweName(index: Int) -> String {
        return arrayStruct[index].followeName ?? ""
    }
    
    public func getFollwerDesciption(index: Int) -> String {
        return arrayStruct[index].follwerDesciption ?? ""
    }
    
    public func getTodayFocusTime(index: Int) -> Int {
        return arrayStruct[index].todayFocusTime ?? 0
    }
    
    public func getBrokenCount(index: Int) -> Int {
        return arrayStruct[index].brokenCount ?? 0
    }
    
    
//    public func inputData(image: String, name: String, location: String, price: String) {
//        self.arrayHomeStruct.append(HomeTabStruct(image: image, name: name, location: location, price: price))
//    }
    
//    public func removeData() {
//        self.arrayHomeStruct.removeLast()
//    }
    
}
