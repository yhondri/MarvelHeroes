//
//  NSObjectExtension.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
