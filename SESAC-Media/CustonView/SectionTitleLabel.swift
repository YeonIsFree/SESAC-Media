//
//  SectionTitleLabel.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import UIKit

class SectionTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        font = .boldSystemFont(ofSize: 20)
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
