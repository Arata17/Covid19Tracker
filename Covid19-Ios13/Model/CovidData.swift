//
//  CovidModel.swift
//  Covid19-Ios13
//
//  Created by Мирас on 7/3/20.
//  Copyright © 2020 Мирас. All rights reserved.
//

import Foundation

struct CovidData: Decodable {
    let Global: Global
    let Countries: [Countries]
    
}

struct Global: Decodable {
    let TotalConfirmed: Int?
    let TotalDeaths: Int?
    let TotalRecovered: Int?
}

struct Countries: Decodable {
    let Country: String?
    let Slug: String?
    let TotalConfirmed: Int?
    let TotalDeaths: Int?
    let TotalRecovered: Int?
}

