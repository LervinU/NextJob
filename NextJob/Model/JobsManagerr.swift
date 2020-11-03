//
//  JobsManagerr.swift
//  NextJob
//
//  Created by Lervin Urena on 10/26/20.
//

import Foundation

struct JobsManager {
    func requestJobs() {
        let Url = String(format: "http://newnexusvacantsapp-env.eba-ismjscyn.us-east-2.elasticbeanstalk.com/jobs")
            guard let serviceUrl = URL(string: Url) else { return }

            var request = URLRequest(url: serviceUrl)
            let defaults = UserDefaults.standard
            let token = defaults.string(forKey: "sessionToken")
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "Authorization")
        
//        if let js = try? JSONSerialization.jsonObject(with: httpBody!, options: []) {
//            print(js)
//        }
        
            request.timeoutInterval = 20
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    self.parseJSON(jobsData: data)
                }
            }.resume()
    }

    
    func parseJSON(jobsData: Data) {
        let decorder = JSONDecoder()
        do {
            let decodedData = try decorder.decode(JobsModel.self, from: jobsData)
            if decodedData.accessToken != nil {

//                print(accessToken)
                let defaults = UserDefaults.standard
                defaults.setValue(decodedData.accessToken, forKey: "sessionToken")
            }
        } catch {
            print(error)
        }
    }
}
