//
//  String+JSONConvert.swift
//  TheMovieApp
//
//  Created by Chandra Rao on 26/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDictionary() -> Any? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
