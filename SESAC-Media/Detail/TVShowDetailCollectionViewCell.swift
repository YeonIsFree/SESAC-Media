//
//  TVShowDetailCollectionViewCell.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import UIKit

class TVShowDetailCollectionViewCell: UICollectionViewCell {
    
    let imageView = ShowImage(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderCollectionViewCell() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
    }
}
