//
//  JobData.swift
//  NextJob
//
//  Created by Lervin Urena on 10/26/20.
//

import Foundation

struct JobData: Decodable {
    var id: Int?
    var name: String?
    var shortDescription: String?
    var longDescription: String?
    var department: String?
    var creationDate: String?
    var rol: String?
    var details: [String]?
}
