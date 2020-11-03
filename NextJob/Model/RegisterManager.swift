//
//  RegisterManager.swift
//  NextJob
//
//  Created by Lervin Urena on 10/22/20.
//

import Foundation


var code: Int?
var message: String?
var statusCode: Int?


struct RegisterManager {
    func register(username: String, password: String, fullname: String, email: String, gender: String) {
        let Url = String(format: "http://newnexusvacantsapp-env.eba-ismjscyn.us-east-2.elasticbeanstalk.com/auth/signup")
            guard let serviceUrl = URL(string: Url) else { return }
            let parameters: [String: Any] = [
                
                "username" : username,
                "password":  password,
                "fullName": fullname,
                "email": email,
                "gender": gender
                
            ]
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        if let js = try? JSONSerialization.jsonObject(with: httpBody!, options: []) {
            print(js)
        }
        
            request.httpBody = httpBody
            request.timeoutInterval = 20
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    parseJSON(registerData: data)
                
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        parseJSON(loginData: json)
//                    } catch {
//                        print(error)
//                    }
                }
            }.resume()
        }
    
    
    func parseJSON(registerData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RegisterData.self, from: registerData)
            if decodedData.code != nil {
                code = decodedData.code
            } else {
                statusCode = decodedData.statusCode
                message = decodedData.message
            }
            print(decodedData)
        } catch {
            print(error)
        }
    }
    
    func getCode() -> Int? {
        return code
    }
    
    func getMessage() -> String? {
        return message
    }
}
