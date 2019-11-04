//
//  TableViewController.swift
//  
//
//  Created by 1 on 9/8/19.
//

import UIKit
import CountryList
import SVProgressHUD
import SCLAlertView
import Firebase

class HolidaysViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var holidays: [Holiday] = []
    
    let countryList = CountryList()
    
    func getHolidays() {
        SVProgressHUD.show()
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let formattedDate = format.string(from: date)
        
        HolidayService.shared.getHolidays(Int(formattedDate)!, UserDefaults.standard.string(forKey: "countryCode") ?? "US", success: { (code, holidays) in
            SVProgressHUD.dismiss()
            for holiday in holidays {
                self.holidays.append(holiday)
            }
            
            self.tableView.reloadData()
        }) { (code) in
            SVProgressHUD.dismiss()
            SCLAlertView().showError("", subTitle: "Your country is not on the backend yet or your request errored.")
            print(code)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height)
            make.left.right.bottom.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = UserDefaults.standard.string(forKey: "countryCode")
        
        countryList.delegate = self
        
        let selectCountryButton = UIBarButtonItem(title: "Select Country", style: .plain, target: self, action: #selector(selectCountryTapped))
        self.navigationItem.rightBarButtonItem = selectCountryButton
        
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutTapped))
        self.navigationItem.leftBarButtonItem = logOutButton
        
        self.view.addSubview(tableView)
        
        let nib = UINib.init(nibName: "HolidayTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "HolidayTableViewCell")
        
        
        
        getHolidays()
        
    }
    
    
    @objc func selectCountryTapped() {
        
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
        
    }
    
    @objc func logOutTapped() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }

        let controller = UINavigationController(rootViewController: WelcomeViewController())
        self.present(controller, animated: true, completion: nil)
    }
    


}

extension HolidaysViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HolidayTableViewCell") as! HolidayTableViewCell
        cell.selectionStyle = .none
        cell.localNameLabel.text = holidays[indexPath.row].name
        cell.dateLabel.text = holidays[indexPath.row].date
        return cell
    }
    
}

extension HolidaysViewController: CountryListDelegate {
    
    func selectedCountry(country: Country) {
        print(country.countryCode)
        title = country.countryCode
        UserDefaults.standard.setValue(country.countryCode, forKey: "countryCode")
        holidays = []
        getHolidays()
    }
}
