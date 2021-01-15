//
//  getData.swift
//  Covid iOS Tracker
//
//  Created by Admin on 10/11/20.
//

import Foundation




class getData: ObservableObject {
    @Published var data : TotalJson!
    
    init(){
        self.updateData()
    }
    
    func updateData(){
        let url = "https://cotizaciones-brou.herokuapp.com/api/currency/latest"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){ data, _ , err in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSONDecoder().decode(TotalJson.self, from: data!)
            DispatchQueue.main.async {
                self.data = json
            }
        }
        .resume()
        
        
    }
}

struct CurrencyDetail: Decodable {
    var sell : Double
    var buy : Double
}

struct Currency: Decodable {
    var USD: CurrencyDetail
}

struct TotalJson: Decodable {
    var base : String
    var rates : Currency
}
