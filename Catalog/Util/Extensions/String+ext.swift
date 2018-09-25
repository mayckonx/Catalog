//
//  String+ext.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation

extension String {
    /// Receive a Date object in a format of yyyy-MM-dd and convert to a presentation format dd/MM/yyyy
    static func presentationDate(_ stringDate: String) -> String {
        let formatter = DateFormatter()
        // convert string to date
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let presentationDate = formatter.date(from: stringDate) else {
            //print("Date:\(stringDate) doesn't conform to yyyy-MM-dd model")
            return ""
        }
        //then again set the date format whhich type of output needed
        formatter.dateFormat = "dd/MM/yyyy"
        // again convert date to string
        return formatter.string(from: presentationDate)
    }
}


