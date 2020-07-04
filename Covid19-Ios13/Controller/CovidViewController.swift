//
//  ViewController.swift
//  Covid19-Ios13
//
//  Created by Мирас on 7/2/20.
//  Copyright © 2020 Мирас. All rights reserved.
//

import UIKit
import Alamofire

class CovidViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    var covidManager = CovidManager(baseUrl: "https://api.covid19api.com/summary")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        covidManager.delegate = self
        covidManager.getData(countryName: "World")
    }
    
    @IBAction func worldStatusButtonPressed(_ sender: Any) {
        covidManager.getData(countryName: "World")
       }

    
}

extension CovidViewController: UITextFieldDelegate{
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Search"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let country = searchTextField.text{
            covidManager.getData(countryName: country)
        }
        searchTextField.text = ""
    }
}

extension CovidViewController: CovidManagerDelegate{
    func didUpdateData(_ covidManager: CovidManager, covidModel: CovidModel) {
        DispatchQueue.main.async {
            self.countryLabel.text = covidModel.countryName
            self.totalCasesLabel.text = String(covidModel.totalCases)
            self.deathsLabel.text = String(covidModel.totalDeaths)
            self.recoveredLabel.text = String(covidModel.totalRecovered)
            self.countryFlag.image = UIImage(named: "\(covidModel.slug)")
        }
    }
    
    
}
