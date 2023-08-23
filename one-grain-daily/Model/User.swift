//
//  User.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/22.
//

import Foundation
import Alamofire

//​http://115.85.183.243:8080/v1​/user​/getUserInfo


//func getUserInfo(completion: @escaping (UserInfo?, Error?) -> Void) {
//    let urlString = "http://115.85.183.243:8080/v1/user/getUserInfo"
//    
//    AF.request(urlString,headers: ["Content-Type":"application/json", "Accept":"application/json"])).responseDecodable(of: UserInfo.self) { response in
//        switch response.result {
//        case .success(let userInfo):
//            completion(userInfo, nil)
//        case .failure(let error):
//            completion(nil, error)
//        }
//    }
//}
