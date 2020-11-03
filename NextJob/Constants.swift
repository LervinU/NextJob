//
//  Constants.swift
//  NextJob
//
//  Created by Lervin Urena on 10/28/20.
//

import Foundation
import UIKit

struct K {
    static let techDepartment = "Tecnologia"
    static let marketingDepartment = "Marketing"
    static let contDepartment = "Contabilidad"
    static let cellNibName = "JobCell"
    static let cellIdentifier = "JobCell"
    static let headerTitles = ["TECNOLOGÍA", "MARKETING", "CONTABILIDAD"]
    static let sectionColors = [#colorLiteral(red: 0.07450980392, green: 0.2039215686, blue: 0.3882352941, alpha: 1), #colorLiteral(red: 0.8862745098, green: 0.1607843137, blue: 0.1607843137, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)]
    static let sectionImages:[UIImage] = [
        UIImage(named: "tecnologiaWhite")!,
        UIImage(named: "marketingWhite")!,
        UIImage(named: "contabilidadWhite")!
    ]
}
