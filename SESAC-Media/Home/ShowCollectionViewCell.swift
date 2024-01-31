//
//  ShowCollectionViewCell.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import UIKit

class ShowCollectionViewCell: UICollectionViewCell {
    
    let showImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderCollectionViewCell() {
        contentView.addSubview(showImageView)
        showImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
