//
//  CarouselViewController.swift
//  NextJob
//
//  Created by Lervin Urena on 11/3/20.
//

import UIKit
import iCarousel

class CarouselViewController: UIViewController, iCarouselDataSource {
    
    var jobs: [JobData]?
    var selectedJobIndex: Int?

    @IBOutlet weak var bgView: UIView!
    
    let carousel: iCarousel = {
        let view = iCarousel()
        view.type = .coverFlow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.addSubview(carousel)
        carousel.dataSource = self
        
        carousel.frame = CGRect(x: 0,
                                y: 300,
                                width: view.frame.size.width,
                                height: 400)
        if let safeIndex = selectedJobIndex {
            carousel.scrollToItem(at: safeIndex, animated: false)
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return jobs!.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.3, height: 650))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = #colorLiteral(red: 0.6674359441, green: 0.6634706855, blue: 0.6704853773, alpha: 1)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 3
        
        let imgContainer = UIView(frame: CGRect(x: 100, y: -36, width: 120, height: 120))
        imgContainer.backgroundColor = UIColor.white
        imgContainer.layer.cornerRadius = 10
        imgContainer.layer.shadowColor = #colorLiteral(red: 0.6674359441, green: 0.6634706855, blue: 0.6704853773, alpha: 1)
        imgContainer.layer.shadowOpacity = 0.6
        imgContainer.layer.shadowOffset = CGSize(width: 0, height: 0)
        imgContainer.layer.shadowRadius = 3
        
        let img = UIImageView(image: self.selectImage(department: jobs![index].department!))
        img.frame = CGRect(x: 20, y: 20, width: 80, height: 80)
        imgContainer.addSubview(img)
        view.addSubview(imgContainer)
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 90, width: view.frame.size.width, height: 50))
        lblTitle.text = jobs![index].name
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont(name: "Nunito-SemiBold", size: 18)
        view.addSubview(lblTitle)
        
        let lblTime = UILabel(frame: CGRect(x: 0, y: 122, width: view.frame.size.width, height: 30))
        lblTime.text = timeAgo(date: jobs![index].creationDate!)
        lblTime.textAlignment = .center
        lblTime.font = UIFont(name: "Nunito", size: 13)
        lblTime.textColor = #colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1)
        view.addSubview(lblTime)
        
        let divisorOne = UIView(frame: CGRect(x: 0, y: 150, width: view.frame.size.width, height: 1))
        divisorOne.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(divisorOne)
        
        let lblJobDescTitle = UILabel(frame: CGRect(x: 20, y: 155, width: view.frame.size.width, height: 30))
        lblJobDescTitle.text = "Descripción de empleo"
        lblJobDescTitle.textAlignment = .left
        lblJobDescTitle.font = UIFont(name: "Nunito-SemiBold", size: 14)
        view.addSubview(lblJobDescTitle)
        
        let lblJobDesc = UILabel(frame: CGRect(x: 20, y: 180, width: view.frame.size.width - 30, height: 110))
        lblJobDesc.text = jobs![index].longDescription
        lblJobDesc.textAlignment = .left

        lblJobDesc.numberOfLines = 10
        lblJobDesc.lineBreakMode = .byTruncatingTail
        lblJobDesc.font = UIFont.systemFont(ofSize: 11)
        view.addSubview(lblJobDesc)
        
        let divisorTwo = UIView(frame: CGRect(x: 0, y: 300, width: view.frame.size.width, height: 1))
        divisorTwo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(divisorTwo)
        
        let lblJobDetTitle = UILabel(frame: CGRect(x: 20, y: 310, width: view.frame.size.width, height: 30))
        lblJobDetTitle.text = "Detalles de empleo"
        lblJobDetTitle.textAlignment = .left
        lblJobDetTitle.font = UIFont(name: "Nunito-SemiBold", size: 14)
        view.addSubview(lblJobDetTitle)
        
        let detailScrollView = UIScrollView(frame: CGRect(x: 20, y: 320, width: view.frame.size.width - 25, height: 280))
        view.addSubview(detailScrollView)
        
        let jobDetails = UILabel(frame: CGRect(x: 0, y: 0, width: detailScrollView.frame.size.width, height: detailScrollView.frame.size.height))
        jobDetails.numberOfLines = 50
        let htmlText = jobs![index].details?.joined(separator: "")
        jobDetails.attributedText = htmlText!.htmlToAttributedString
        jobDetails.font = UIFont.systemFont(ofSize: 12)
        detailScrollView.addSubview(jobDetails)
        
        
        let shareImg = UIImage(named: "shareWhite")
        
        let shareBtn = UIButton(frame: CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 50))
        shareBtn.backgroundColor = #colorLiteral(red: 0.2823529412, green: 0.2431372549, blue: 0.9098039216, alpha: 1)
//        shareBtn.setImage(shareImg, for: .normal)
//        shareBtn.imageView?.contentMode = .scaleAspectFill
        shareBtn.setTitle("COMPARTIR", for: .normal)
        shareBtn.titleLabel?.font = UIFont(name: "Nunito-SemiBold", size: 18)
        shareBtn.semanticContentAttribute = .forceLeftToRight
//        shareBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: -10, bottom: 10, right: 10)
//        shareBtn.titleEdgeInsets = UIEdgeInsets(top: 10, left: -80, bottom: 10, right: 80)
        
        view.addSubview(shareBtn)
        
        return view
    }
    
    
    func selectImage(department: String) -> UIImage {
        switch department {
        case K.marketingDepartment:
            return UIImage(named: "marketingBlue")!

        case K.techDepartment:
            return UIImage(named: "Iconos developer")!

        case K.contDepartment:
            return UIImage(named: "contabilidadBlue")!

        default:
            return UIImage(named: "contabilidadBlue")!
        }
    }
    
    func timeAgo(date: String) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let fromDate = formatter1.date(from: date) ?? Date()
        
        
        // ask for the full relative date
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "es_419")
        formatter.unitsStyle = .full

        // get exampleDate relative to the current date
        let relativeDate = formatter.localizedString(for: fromDate, relativeTo: Date())
        return relativeDate
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
