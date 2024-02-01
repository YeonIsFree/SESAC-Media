//
//  DetailSections.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/02.
//

import Foundation

// TVShowTableView

enum TVShowSections: Int, CaseIterable {
    case details = 0
    case recommand = 1
    case cast = 2
    
    var title: String {
        switch self {
        case .details:
            return ""
        case .recommand:
            return "비슷한 작품"
        case .cast:
            return "캐스팅 정보"
        }
    }
}
