//
//  FollwerDataModel.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/29.
//

import Foundation

class FollwerDataModel {
    
    public var arrayStruct: [follwerInfo] = [
        follwerInfo(image: "imoge_1.png", numberOfFollower: 13, focusTimeForThisMonth: 23, followeName: "Jason", follwerDesciption: "오늘을 이롭게", todayFocusTime: 49, brokenCount: 5),
        follwerInfo(image: "imoge_2.png", numberOfFollower: 29, focusTimeForThisMonth: 92, followeName: "Soey", follwerDesciption: "내일을 새롭게", todayFocusTime: 23, brokenCount: 3),
        follwerInfo(image: "imoge_3.png", numberOfFollower: 13, focusTimeForThisMonth: 29, followeName: "Emma", follwerDesciption: "오늘도 화이팅", todayFocusTime: 82, brokenCount: 2)
   ]
    
    public var newEventArrayModel = [
        ["2022-08-01"],
        ["2022-08-02"],
        ["2022-08-03"]
   ]
    
    public var newZandiArrayModel = [
        [100],
        [300],
        [500]
   ]
    
    public func getNewEventArray(index: Int) -> Array<Any> {
        return newEventArrayModel[index]
    }
    
    public func getNewZandiArrayModel(index: Int) -> Array<Any> {
        return newZandiArrayModel[index]
    }
    
    public func inputNewEventArray(array:Array<Any>) {
        self.newEventArrayModel.append(array as! [String])
    }
    
    public func inputNewZandiArray(array:Array<Any>) {
        self.newZandiArrayModel.append(array as! [Int])
    }
    
    public func inputData(image:String, numberOfFollower:Int, focusTimeForThisMonth:Int, followeName:String, follwerDesciption:String, todayFocusTime:Int, brokenCount:Int) {
        self.arrayStruct.append(follwerInfo(image: image, numberOfFollower: numberOfFollower, focusTimeForThisMonth: focusTimeForThisMonth, followeName: followeName, follwerDesciption: follwerDesciption, todayFocusTime: todayFocusTime, brokenCount: brokenCount))
    }

    public func removeFromDataModel(index:Int) {
        self.arrayStruct.remove(at: index)
        self.newEventArrayModel.remove(at: index)
        self.newZandiArrayModel.remove(at: index)
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
