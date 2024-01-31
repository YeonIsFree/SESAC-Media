//
//  DetailCollectionViewCell.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import UIKit

class RecommandCollectionViewCell: UICollectionViewCell {
    
    let recommandImage = ShowImage(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        contentView.addSubview(recommandImage)
        recommandImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}

