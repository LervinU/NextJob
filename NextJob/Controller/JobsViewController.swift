//
//  JobsViewController.swift
//  NextJob
//
//  Created by Lervin Urena on 10/26/20.
//

import UIKit

class JobsViewController: UIViewController {
    
    var jobs: [JobData]?
    var filteredJobs: [JobData]?
    var filterByPosition = [[JobData]]()
    
    var searchActive = false
    var positionFilterActive: Bool?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var alphaFilter: UIButton!
    @IBOutlet weak var dateFilter: UIButton!
    @IBOutlet weak var positionFilter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionFilterActive = false
        
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchBar.searchTextField.textColor = #colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1)
        searchBar.searchTextField.font = UIFont(name: "Nunito-Bold", size: 17.0)
        

        alphaFilter.layer.borderColor = #colorLiteral(red: 0.3562973142, green: 0.355602622, blue: 0.9289687872, alpha: 1)
        alphaFilter.layer.borderWidth = 1


        dateFilter.layer.borderColor = #colorLiteral(red: 0.3562973142, green: 0.355602622, blue: 0.9289687872, alpha: 1)
        dateFilter.layer.borderWidth = 1
        

        positionFilter.layer.borderColor = #colorLiteral(red: 0.3562973142, green: 0.355602622, blue: 0.9289687872, alpha: 1)
        positionFilter.layer.borderWidth = 1
        

        
        getJobs() { result in
            self.jobs = result
            self.filteredJobs = result
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.rowHeight = 100.0
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == K.detailSegueIdentifier) {
            let carouselVC = segue.destination as! CarouselViewController
            carouselVC.jobs = self.jobs
        }
    }
    
    
    @IBAction func filterAlpha(_ sender: UIButton) {
        positionFilterActive = false
        self.filteredJobs = self.jobs?.sorted{$0.name! < $1.name!}
        
        alphaBtnChange()
        self.tableView.reloadData()
    }
    @IBAction func filterDate(_ sender: Any) {
        positionFilterActive = false
        self.filteredJobs = self.jobs?.sorted{$0.creationDate! > $1.creationDate!}
        
        dateBtnChange()
        self.tableView.reloadData()
    }
    @IBAction func filterPosition(_ sender: UIButton) {
        var tempArr = [[JobData]]()
        positionFilterActive = true
        for _ in 0...2 {
            tempArr.append([JobData]())
        }

        for index in 0...jobs!.count - 1{
            if(self.jobs?[index].department! == K.techDepartment) {
                tempArr[0].append((jobs?[index])!)
            }
            else if(self.jobs?[index].department == K.marketingDepartment) {
                tempArr[1].append((jobs?[index])!)
            }
            else if(self.jobs?[index].department == K.contDepartment) {
                tempArr[2].append((jobs?[index])!)
            }
        }
        self.filterByPosition = tempArr
        positionBtnChange()
        self.tableView.reloadData()
        tempArr = []
        


    }
    
    
    func getJobs(_ completion: @escaping (_ result: [JobData]?)->()) {
        let jobsManager = JobsManager()
        jobsManager.getJobs() { (result) -> () in
            completion(result)
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
    
    func alphaBtnChange() {
        alphaFilter.backgroundColor = #colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1)
        alphaFilter.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        dateFilter.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dateFilter.setTitleColor(#colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1), for: .normal)
        
        positionFilter.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        positionFilter.setTitleColor(#colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1), for: .normal)
    }
    
    func dateBtnChange() {
        dateFilter.backgroundColor = #colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1)
        dateFilter.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        alphaFilter.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        alphaFilter.setTitleColor(#colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1), for: .normal)
        
        positionFilter.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        positionFilter.setTitleColor(#colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1), for: .normal)
    }
    
    func positionBtnChange() {
        positionFilter.backgroundColor = #colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1)
        positionFilter.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        dateFilter.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dateFilter.setTitleColor(#colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1), for: .normal)
        
        alphaFilter.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        alphaFilter.setTitleColor(#colorLiteral(red: 0.7139809728, green: 0.7036961317, blue: 0.9632331729, alpha: 1), for: .normal)
    }

}

extension JobsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if positionFilterActive == true {
            return filterByPosition[section].count
        } else {
            if let safeInt = filteredJobs?.count {
                return safeInt
            }
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! JobCell
        if positionFilterActive == true {
            let cellData = filterByPosition[indexPath.section][indexPath.row]
            cell.jobTitle.text = cellData.name
            cell.jobShortDesc.text = cellData.shortDescription
            cell.jobDate.text = timeAgo(date: cellData.creationDate!)
            cell.imgSquare.layer.borderWidth = 2.0
            cell.imgSquare.layer.borderColor = #colorLiteral(red: 0.3562973142, green: 0.355602622, blue: 0.9289687872, alpha: 1)
            cell.jobImage.image = self.selectImage(department: cellData.department!)
            
            return cell
        } else {
            if let safeText = filteredJobs?[indexPath.row] {
                cell.jobTitle.text = safeText.name
                cell.jobShortDesc.text = safeText.shortDescription
                cell.jobDate.text = timeAgo(date: safeText.creationDate!)
                cell.imgSquare.layer.borderWidth = 2.0
                cell.imgSquare.layer.borderColor = #colorLiteral(red: 0.3562973142, green: 0.355602622, blue: 0.9289687872, alpha: 1)
                cell.jobImage.image = self.selectImage(department: safeText.department!)

                return cell
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if positionFilterActive == true {
            return self.filterByPosition.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if positionFilterActive == true {
            let view = UIView()
            view.backgroundColor = K.sectionColors[section]
            
            let image = UIImageView(image: K.sectionImages[section])
            image.frame = CGRect(x: 130, y: 12, width: 20, height: 20)
            view.addSubview(image)
        
            let label = UILabel()
            label.text = K.headerTitles[section]
            label.textColor = UIColor.white
            label.font = UIFont(name: "NotoSans-Bold", size: 17)
            label.frame = CGRect(x: 160, y: 5, width: 200, height: 35)
            view.addSubview(label)

            return view
        }
       return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if positionFilterActive == true {
            return 45
        }
            return 0
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "carousel", sender: self)
    }
}

extension JobsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.positionFilterActive = false
        self.filteredJobs = searchText.isEmpty ? self.jobs : jobs?.filter { (item: JobData) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.searchActive = !filteredJobs!.isEmpty
        self.tableView.reloadData()
    }
}
