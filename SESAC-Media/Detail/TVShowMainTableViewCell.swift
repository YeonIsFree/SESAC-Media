//
//  DetailTableViewCell.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import UIKit

class TVShowMainTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    let sectionTitleLabel = SectionTitleLabel()
    let showImageView: ShowImage = {
        let imageView = ShowImage(frame: .zero)
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    let showTitleLabel: SectionTitleLabel = {
        let label = SectionTitleLabel()
        label.text = "프렌즈"
        return label
    }()
    
    let showOverviewLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 길고 긴 줄거리 같은 것이 들어온다. 아주 길겠지. 한 다섯줄 되려나 \n 여기에 길고 긴 줄거리 같은 것이 들어온다. 아주 길겠지. 한 다섯줄 되려나 \n 여기에 길고 긴 줄거리 같은 것이 들어온다. 아주 길겠지. 한 다섯줄 되려나 \n 여기에 길고 긴 줄거리 같은 것이 들어온다. 아주 길겠지. 한 다섯줄 되려나"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
     // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: -
    
    func render() {
        contentView.addSubview(sectionTitleLabel)
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(showImageView)
        showImageView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(350)
        }
        
        showImageView.addSubview(showTitleLabel)
        showTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(showOverviewLabel)
        showOverviewLabel.snp.makeConstraints { make in
            make.top.equalTo(showImageView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(contentView).inset(8)
        }
    }
}

