//
//  SignUpFunc.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//

import Foundation
import Alamofire

func sendPostRequest(_ url: String, parameters: [String: String], completion: @escaping ([String: Any]?, Error?) -> Void) {
    let targetUrl = URL(string: url)
    let paramData = try? JSONSerialization.data(withJSONObject: parameters)

    guard let targetUrl = URL(string: url) else {
        // 잘못된 URL 문자열에 대한 처리
        print("Invalid URL")
        // 또는 오류 처리 로직을 추가할 수 있음
        return
    }
    var request = URLRequest(url: targetUrl)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = paramData
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard
            let data = data,                              // is there data
            let response = response as? HTTPURLResponse,  // is there HTTP response
            200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
            error == nil                                  // was there no error
        else {
            completion(nil, error)
            return
        }
        let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
        if let responseObject = responseObject {
            print("[responseObject]----------->", responseObject)
            completion(responseObject, nil)
        } else {
            // responseObject가 nil일 때의 처리
            completion(nil, nil) // 또는 오류 처리 로직을 추가할 수 있음
        }

    }
    task.resume()
    
    
}

//로그인 시 헤더 정보를 받아오는 함수
func loginAndFetchHeaders(username: String, password: String) {
    let loginUrl = URL(string: "http://115.85.183.243:8080/login")!

    // Step 1: Create a URLSession
    let session = URLSession.shared

    // Step 2: Create a URLRequest with the login URL
    var request = URLRequest(url: loginUrl)
    request.httpMethod = "POST"

    // Step 3: Set up the request body with username and password
    let parameters: [String: Any] = [
        "username": username,
        "password": password
    ]

    do {
        let requestData = try JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = requestData
    } catch {
        print("Error serializing JSON: \(error)")
        return
    }

    // Step 4: Send the login request
    let loginTask = session.dataTask(with: request) { data, response, error in
        guard let data = data, let httpResponse = response as? HTTPURLResponse else {
            if let error = error {
                print("Request error: \(error)")
            }
            return
        }

        // Step 5: Check the response status code
        if 200 ..< 300 ~= httpResponse.statusCode {
            // Login successful, print response headers
            let headers = httpResponse.allHeaderFields
            print("Response Headers:")
            for (key, value) in headers {
                print("\(key): \(value)")
            }
        } else {
            // Login failed, handle the error
            print("Login failed with status code: \(httpResponse.statusCode)")
        }
    }

    // Step 6: Start the login task
    loginTask.resume()
}



