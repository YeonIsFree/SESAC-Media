//
//  Identifiable.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIView: Identifiable { }
