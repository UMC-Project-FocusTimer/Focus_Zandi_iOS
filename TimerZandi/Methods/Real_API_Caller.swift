//
//  ViewController.swift
//  newtorkEx
//
//  Created by 이주송 on 2022/06/30.
//

import UIKit
import Security
import Alamofire


//MARK: - GET
    
    //MARK: - 1.1 유저 정보 조회
    func getShowMember(accessToken:String, refToken:String, onCompleted: @escaping (Result<showMember,Error>)-> Void) {
        let url = "https://aquistion.shop/showMember"
        AF.request(url,
                   method:.get, // 어떤 통신방식을 사용할 지
                   parameters: nil, // 서버로 보낼 parameter를 담는 것(POST)
                   encoding: URLEncoding.default, // URL을 통해 접근할 것이니 URLEncoding
                   headers: ["ACCESS_TOKEN":accessToken, "REFRESH_TOKEN":refToken]) // json 형식으로 받게끔
        .validate(statusCode: 200..<500) // 에러여부
        .responseData(completionHandler: { response in // 응답데이터를 받을수 있는 메소드를 Chaning
            switch response.result { // 요청에 대한 응답 결과
            case let .success(data): // 요청 O
                do { // 요청 O 응답 O
                    let decoder = JSONDecoder()
                    // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
                    let result = try decoder.decode(showMember.self, from: data)
                    // 서버에서 전달받은 data를 매핑시켜줄 객체타입으로 CityCovideOverview를 설정
                    onCompleted(.success(result))

                    // 응답이 완료되면. Completion Handler가 호출됨 -> result를 넘겨받아 data가 구조체로 매핑
                } catch { // 요청 O 응답 X
                    print("error")
                    onCompleted(.failure(error))

                    // 응답을 못받으면 error를 받음
                }
                
            case let .failure(error): // 요청 X
                onCompleted(.failure(error))
            }
        })
    }

    //MARK: - 2.2 월별 공부내역 조회
    func getMonthRecords(accessToken:String, refToken:String, onCompleted: @escaping (Result<MonthRecords,Error>)-> Void) {
        let url = "https://aquistion.shop/records/monthly?month=08"
        AF.request(url,
                   method:.get, // 어떤 통신방식을 사용할 지
                   parameters: nil, // 서버로 보낼 parameter를 담는 것(POST)
                   encoding: URLEncoding.default, // URL을 통해 접근할 것이니 URLEncoding
                   headers: ["ACCESS_TOKEN":accessToken, "REFRESH_TOKEN":refToken]) // json 형식으로 받게끔
        .validate(statusCode: 200..<500) // 에러여부
        .responseData(completionHandler: { response in // 응답데이터를 받을수 있는 메소드를 Chaning
            switch response.result { // 요청에 대한 응답 결과
            case let .success(data): // 요청 O
                do { // 요청 O 응답 O
                    let decoder = JSONDecoder()
                    // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
                    let result = try decoder.decode(MonthRecords.self, from: data)
                    // 서버에서 전달받은 data를 매핑시켜줄 객체타입으로 CityCovideOverview를 설정
                    onCompleted(.success(result))
                    print(result)
                    // 응답이 완료되면. Completion Handler가 호출됨 -> result를 넘겨받아 data가 구조체로 매핑
                } catch { // 요청 O 응답 X
                    print("error")
                    onCompleted(.failure(error))

                    // 응답을 못받으면 error를 받음
                }
                
            case let .failure(error): // 요청 X
                onCompleted(.failure(error))
            }
        })
    }

    //MARK: - 4.1 친구추가
func addFriend(follweeName:String, accessToken:String, refToken:String, onCompleted: @escaping (Result<AddFriend,Error>)-> Void) {
    let url = "https://aquistion.shop/addFriend/\(follweeName)"
    AF.request(url,
               method:.get, // 어떤 통신방식을 사용할 지
               parameters: nil, // 서버로 보낼 parameter를 담는 것(POST)
               encoding: URLEncoding.default, // URL을 통해 접근할 것이니 URLEncoding
               headers: ["ACCESS_TOKEN":accessToken, "REFRESH_TOKEN":refToken]) // json 형식으로 받게끔
    .validate(statusCode: 200..<500) // 에러여부
    .responseData(completionHandler: { response in // 응답데이터를 받을수 있는 메소드를 Chaning
        switch response.result { // 요청에 대한 응답 결과
        case let .success(data): // 요청 O
            do { // 요청 O 응답 O
                let decoder = JSONDecoder()
                // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
                let result = try decoder.decode(AddFriend.self, from: data)
                // 서버에서 전달받은 data를 매핑시켜줄 객체타입으로 CityCovideOverview를 설정
                onCompleted(.success(result))
                print(result)
                // 응답이 완료되면. Completion Handler가 호출됨 -> result를 넘겨받아 data가 구조체로 매핑
            } catch { // 요청 O 응답 X
                print("error")
                onCompleted(.failure(error))

                // 응답을 못받으면 error를 받음
            }
            
        case let .failure(error): // 요청 X
            onCompleted(.failure(error))
        }
    })
    
}

    //MARK: - 4.4 친구 수 조회
    func getNumberOfFollowers(accessToken:String, refToken:String, onCompleted: @escaping (Result<FNumber,Error>)-> Void) {
        let url = "https://aquistion.shop/getNumberOfFollowers"
        AF.request(url,
                   method:.get, // 어떤 통신방식을 사용할 지
                   parameters: nil, // 서버로 보낼 parameter를 담는 것(POST)
                   encoding: URLEncoding.default, // URL을 통해 접근할 것이니 URLEncoding
                   headers: ["ACCESS_TOKEN":accessToken, "REFRESH_TOKEN":refToken]) // json 형식으로 받게끔
        .validate(statusCode: 200..<500) // 에러여부
        .responseData(completionHandler: { response in // 응답데이터를 받을수 있는 메소드를 Chaning
            switch response.result { // 요청에 대한 응답 결과
            case let .success(data): // 요청 O
                do { // 요청 O 응답 O
                    let decoder = JSONDecoder()
                    // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
                    let result = try decoder.decode(FNumber.self, from: data)
                    // 서버에서 전달받은 data를 매핑시켜줄 객체타입으로 CityCovideOverview를 설정
                    onCompleted(.success(result))
                    print(result)
                    // 응답이 완료되면. Completion Handler가 호출됨 -> result를 넘겨받아 data가 구조체로 매핑
                } catch { // 요청 O 응답 X
                    print("error")
                    onCompleted(.failure(error))

                    // 응답을 못받으면 error를 받음
                }
                
            case let .failure(error): // 요청 X
                onCompleted(.failure(error))
            }
        })
    }

//MARK: - POST
    
    //MARK: -  2.1 오늘 공부기록 저장
    func postTodayRecord(accessToken:String, refToken:String, concentratedTime:Int, brokenCount:Int, date:String) {
            let Testurl = URL(string: "https://aquistion.shop/saveRecords/today")!
            
            var profileOBJ = MonthRecord(concentratedTime: concentratedTime, brokenCount: brokenCount, date: date)
    
            guard let jsonData = try? JSONEncoder().encode(profileOBJ) else {
                print("error: cannot encode data")
                return
            }
            print(jsonData)
            
            var request1 = URLRequest(url: Testurl)
            request1.httpMethod = "POST"
            request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request1.setValue("application/json", forHTTPHeaderField: "Accept")
            request1.setValue(accessToken, forHTTPHeaderField: "ACCESS_TOKEN")
            request1.setValue(refToken, forHTTPHeaderField: "REFRESH_TOKEN")
            request1.httpBody = jsonData
            
            
            URLSession.shared.dataTask(with: request1) { (data, response, error) in
                guard error == nil else {
                    print("error at first")
                    print(error)
                    return
                }
                
                guard let data = data else {
                    print("error at data")
                    return
                }
                
                guard let response = response else {
                    print("error at response")
                    return
                }
                
            }.resume()
        }

    //MARK: -  3.1 유저 로그인 (Requset : Body / Respons : AccessToken, RefreshToken)
    func postTestnd(userToken:String, email:String, fullName: String) {
            let Testurl = URL(string: "https://aquistion.shop/oauth/google")!

            var profile = ProfileObj1(userToken: userToken , email: email, fullName: fullName)
            var profileOBJ = Pram(profileObj: profile)
            
            guard let jsonData = try? JSONEncoder().encode(profileOBJ) else {
                print("error: cannot encode data")
                return
            }
            print(jsonData)
            
            var request1 = URLRequest(url: Testurl)
            request1.httpMethod = "POST"
            request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request1.setValue("application/json", forHTTPHeaderField: "Accept")
            request1.httpBody = jsonData
            
            
            URLSession.shared.dataTask(with: request1) { (data, response, error) in
                guard error == nil else {
                    print("error at first")
                    print(error)
                    return
                }
                
                guard let data = data else {
                    print("error at data")
                    return
                }
                
                guard let response = response else {
                    print("error at response")
                    return
                }
                
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("error cannot convert json")
                        return
                    }
                    
                    if let ACCESS_TOKEN = jsonObject["accessToken"],
                        let REF_TOKEN = jsonObject["refToken"]
                    {
//                    getTest(accessToken: ACCESS_TOKEN as! String, refToken: REF_TOKEN as! String)
                        accessToken = ACCESS_TOKEN as! String
                        refToken = REF_TOKEN as! String

                        print("accessToken is \(accessToken)")
                        print("accessToken is \(refToken)")
                    }
                    
                } catch {
                    print("error while print json")
                }

            }.resume()
        }

    //MARK: -  4.3 친구 수 추가
func AddNumberOfFollowers(accessToken:String, refToken:String, numberOfFollowers:Int) {
            let Testurl = URL(string: "https://aquistion.shop/addNumberOfFollowers")!

            let follwerNumber = FNumber_post(numberOfFollowers: numberOfFollowers)
    
            guard let jsonData = try? JSONEncoder().encode(follwerNumber) else {
                print("error: cannot encode data")
                return
            }
            print(jsonData)
            
            var request1 = URLRequest(url: Testurl)
            request1.httpMethod = "POST"
            request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request1.setValue("application/json", forHTTPHeaderField: "Accept")
            request1.setValue(accessToken, forHTTPHeaderField: "ACCESS_TOKEN")
            request1.setValue(refToken, forHTTPHeaderField: "REFRESH_TOKEN")
            request1.httpBody = jsonData
            
            
            URLSession.shared.dataTask(with: request1) { (data, response, error) in
                guard error == nil else {
                    print("error at first")
                    print(error)
                    return
                }
                
                guard let data = data else {
                    print("error at data")
                    return
                }
                
                guard let response = response else {
                    print("error at response")
                    return
                }
                
            }.resume()
        }
  
