//
//  JobsManagerr.swift
//  NextJob
//
//  Created by Lervin Urena on 10/26/20.
//

import Foundation
import Alamofire

struct JobsManager {

    func getJobs(completion: @escaping ([JobData]?) -> Void) {
        let Url = String(format: "http://newnexusvacantsapp-env.eba-ismjscyn.us-east-2.elasticbeanstalk.com/jobs")
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "sessionToken")
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token!)
               ]
        AF.request(Url, headers: headers).responseDecodable(of: [JobData].self) { response in
            guard let jobs = response.value else { return }
            completion(jobs)
        }
    }
    
    

}
