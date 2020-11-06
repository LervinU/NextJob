//
//  LoginManager.swift
//  NextJob
//
//  Created by Lervin Urena on 10/21/20.
//

import Foundation

class LoginManager {
    
    var accessToken: String?
    
    func login(username: String, password: String, completion: @escaping (String?) -> Void) {
        let Url = String(format: "http://newnexusvacantsapp-env.eba-ismjscyn.us-east-2.elasticbeanstalk.com/auth/signin")
            guard let serviceUrl = URL(string: Url) else { return }
            let parameters: [String: Any] = [
                
                        "username" : username,
                        "password":  password
                
            ]
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
//        if let js = try? JSONSerialization.jsonObject(with: httpBody!, options: []) {
//            print(js)
//        }
        
            request.httpBody = httpBody
            request.timeoutInterval = 20
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    self.parseJSON(loginData: data)
                    completion(self.accessToken)
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        parseJSON(loginData: json)
//                    } catch {
//                        print(error)
//                    }
                }
            }.resume()
        }
    
    func parseJSON(loginData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(LoginData.self, from: loginData)
            if decodedData.accessToken != nil {
                    accessToken = decodedData.accessToken
//                print(accessToken)
                let defaults = UserDefaults.standard
                defaults.setValue(decodedData.accessToken, forKey: "sessionToken")
            }
        } catch {
            print(error)
        }
    }
    
    func getAcessToken() -> String?{
        return accessToken
    }
}

