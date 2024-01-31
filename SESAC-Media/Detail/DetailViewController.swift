//
//  DetailViewController.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    var recommandList: [TvShow] = []
    
    // MARK: - UI Properties
    
    let detailTitle = SectionTitleLabel()
    
    let detailImage = ShowImage(frame: .zero)
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let recommandTitle: SectionTitleLabel = {
        let label = SectionTitleLabel()
        label.text = "비슷한 드라마 추천"
        return label
    }()
    
    let recommandCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    let castTitle: UILabel = {
        let label = SectionTitleLabel()
        label.text = "출연 정보"
        return label
    }()
    
    let castLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailShowData()
        configureCollectionView()
        render()
    }
}

// MARK: - Networking

extension DetailViewController {
    func getDetailShowData() {
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            TMDBAPIManager.shared.fetchDetailData { detail in
                self.getImage(detail.backdrop_path)
                self.overviewLabel.text = detail.overview
                self.detailTitle.text = detail.name
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            TMDBAPIManager.shared.fetchRecommandData { list in
                self.recommandList = list
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            TMDBAPIManager.shared.fetchCast { list in
                for cast in list {
                    let prevText = self.castLabel.text ?? ""
                    self.castLabel.text = prevText + cast.name + " | "
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.recommandCollectionView.reloadData()
        }
        
    }
    
    func getImage(_ url: String) {
        if let imageUrl = URL(string: TMDBAPIManager.shared.imageBaseURL + url) {
            detailImage.kf.setImage(with: imageUrl)
        } else { return }
    }
}

// MARK: - UICollectionView Delegate

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommandList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = recommandCollectionView.dequeueReusableCell(withReuseIdentifier: RecommandCollectionViewCell.identifier, for: indexPath) as? RecommandCollectionViewCell else { return UICollectionViewCell() }
        
        let poster = recommandList[indexPath.item].poster_path ?? ""
        if let imageUrl = URL(string: TMDBAPIManager.shared.imageBaseURL + poster) {
            cell.recommandImage.kf.setImage(with: imageUrl)
        }
        
        return cell
    }
}

// MARK: - CollectionView Configuration Method

extension DetailViewController {
    func configureCollectionView() {
        recommandCollectionView.delegate = self
        recommandCollectionView.dataSource = self
        recommandCollectionView.register(RecommandCollectionViewCell.self, forCellWithReuseIdentifier: RecommandCollectionViewCell.identifier)
    }
}

// MARK: - UI Configuration Method

extension DetailViewController {
    func render() {
        view.addSubview(detailImage)
        detailImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }
        
        detailImage.addSubview(detailTitle)
        detailTitle.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        view.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(detailImage.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(150)
        }
        
        view.addSubview(recommandTitle)
        recommandTitle.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(20)
        }
        
        view.addSubview(recommandCollectionView)
        recommandCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommandTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(200)
        }
        
        view.addSubview(castTitle)
        castTitle.snp.makeConstraints { make in
            make.top.equalTo(recommandCollectionView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(20)
        }
        
        view.addSubview(castLabel)
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(castTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(100)
        }
    }
}
