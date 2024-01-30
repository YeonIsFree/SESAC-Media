//
//  TvTableViewCell.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import UIKit

class TvTableViewCell: UITableViewCell {
    
     // MARK: - UI Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .red
        return label
    }()

     // MARK: - initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        renderTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - Cell UI configuration Method
    
    func renderTableViewCell() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
    }
}
