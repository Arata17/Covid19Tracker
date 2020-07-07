//
//  CovidManager.swift
//  Covid19-Ios13
//
//  Created by Мирас on 7/3/20.
//  Copyright © 2020 Мирас. All rights reserved.
//

import Foundation
import Alamofire

protocol CovidManagerDelegate {
    func didUpdateData(_ covidManager: CovidManager, covidModel: CovidModel)
}

struct CovidManager {
    var baseUrl = ""
    //    "https://api.covid19api.com/summary"
    
    var delegate: CovidManagerDelegate?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getData(countryName: String){
        AF.request(self.baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {return}
            if let safeData = self.parseJson(data, countryName: countryName){
                self.delegate?.didUpdateData(self, covidModel: safeData)
            }
        }
    }
    
    func parseJson(_ covidData: Data, countryName: String) -> CovidModel?{

        do{
            let covid = try JSONDecoder().decode(CovidData.self, from: covidData)
            if countryName == "World"{
                let name = "World"
                let slug = "world"
                let cases = covid.Global.TotalConfirmed!
                let deaths = covid.Global.TotalDeaths!
                let recovered = covid.Global.TotalRecovered!
                
                let covidModel = CovidModel(countryName: name, slug: slug, totalCases: cases, totalDeaths: deaths, totalRecovered: recovered)
                return covidModel
            } else{
            for i in 0..<covid.Countries.count{
                if covid.Countries[i].Country == countryName{
                    let name = covid.Countries[i].Country!
                    let slug = covid.Countries[i].Slug!
                    let cases = covid.Countries[i].TotalConfirmed!
                    let deaths = covid.Countries[i].TotalDeaths!
                    let recovered = covid.Countries[i].TotalRecovered!
                    let covidModel = CovidModel(countryName: name, slug: slug, totalCases: cases, totalDeaths: deaths, totalRecovered: recovered)
                    return covidModel
                }
            }
            
        }
        } catch {
            print(error)
        }
        return nil
    }
}
