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
    
    func getTest(accessToken:String, refToken:String) {
        let url = "https://aquistion.shop/showMember"
        AF.request(url,
                   method:.get, // 어떤 통신방식을 사용할 지
                   parameters: nil, // 서버로 보낼 parameter를 담는 것(POST)
                   encoding: URLEncoding.default, // URL을 통해 접근할 것이니 URLEncoding
                   headers: ["ACCESS_TOKEN":accessToken, "REFRESH_TOKEN":refToken]) // json 형식으로 받게끔
        .validate(statusCode: 200..<500) // 에러여부
        .responseJSON{
            (json) in debugPrint(json)
        } // 정보를 받는 부분
        
    }
    
//MARK: - POST
    
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
                    getTest(accessToken: ACCESS_TOKEN as! String, refToken: REF_TOKEN as! String)
                }
                
            } catch {
                print("error while print json")
            }

        }.resume()
    }

  
