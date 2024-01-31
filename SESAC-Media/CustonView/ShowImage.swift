//
//  showImage.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import UIKit

class ShowImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        clipsToBounds = true
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
