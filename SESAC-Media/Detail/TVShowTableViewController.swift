//
//  DetailTableViewController.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import UIKit

class TVShowTableViewController: UIViewController {
    
    let targetSeriesID: Int = 1668 // 최애 미드 "프렌즈"의 id
    var series: TVSeries = TVSeries(id: 0, backdrop_path: "", poster_path: "", name: "", overview: "")
    var recommandList: [TVSeries] = []
    var castList: [Cast] = []
    
    // MARK: - UI Property
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        render()
        getData()
    }
    
    // MARK: - Networking Method
    
    func getData() {
        
        let group = DispatchGroup()
        
        // Details
        group.enter()
        DispatchQueue.global().async(group: group) {
            TMDBAPIManager.shared.fetchSeries(api: .details(id: self.targetSeriesID)) { item in
                self.series = item
                group.leave()
            }
        }
        
        // Recommand
        group.enter()
        DispatchQueue.global().async(group: group)  {
            TMDBAPIManager.shared.fetchSeriesList(api: .recommand(id: self.targetSeriesID)) { list in
                self.recommandList = list
                group.leave()
            }
        }
        
        // Cast
        group.enter()
        DispatchQueue.global().async(group: group) {
            TMDBAPIManager.shared.fetchCast(api: .cast(id: self.targetSeriesID)) { list in
                self.castList = list
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableView Delegate

extension TVShowTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TVShowSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // < 테이블 뷰 첫번째 셀 - 상세 정보 >
        if indexPath.row == TVShowSections.details.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowMainTableViewCell.identifier, for: indexPath) as? TVShowMainTableViewCell else { return UITableViewCell() }
            
            cell.sectionTitleLabel.text = TVShowSections(rawValue: indexPath.row)?.title
            
            if let imagePath = series.poster_path {
                let url = URL(string: TMDBAPI.baseImageURL + imagePath)
                cell.showImageView.kf.setImage(with: url)
            }
            
            cell.showOverviewLabel.text = series.overview
            
            return cell
        }
        else { // < 테이블 뷰 두번째, 세번째 셀 - 컬렉션 뷰 >
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowDetailTableViewCell.identifier, for: indexPath) as? TVShowDetailTableViewCell else { return UITableViewCell() }
            
            // 컬렉션 뷰 등록
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(TVShowDetailCollectionViewCell.self, forCellWithReuseIdentifier: TVShowDetailCollectionViewCell.identifier)
            
            // 컬렉션 뷰에 현재 indexPath.row로 tag 설정
            cell.collectionView.tag = indexPath.row
         
            cell.sectionTitleLabel.text = TVShowSections(rawValue: indexPath.row)?.title
            
            cell.collectionView.reloadData()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return 600 }
        else { return 240 }
    }
}

// MARK: - UITableView Configuration Method

extension TVShowTableViewController {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TVShowMainTableViewCell.self, forCellReuseIdentifier: TVShowMainTableViewCell.identifier)
        tableView.register(TVShowDetailTableViewCell.self, forCellReuseIdentifier: TVShowDetailTableViewCell.identifier)
    }
}


// MARK: - UICollectionView Delegate

extension TVShowTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView.tag == TVShowSections.recommand.rawValue) ? recommandList.count : castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowDetailCollectionViewCell.identifier, for: indexPath) as? TVShowDetailCollectionViewCell else { return UICollectionViewCell() }
        
        // 컬렉션 뷰 셀에 이미지 설정
        switch collectionView.tag {
        case TVShowSections.recommand.rawValue:
            if let imagePath = recommandList[indexPath.row].poster_path {
                let url = URL(string: TMDBAPI.baseImageURL + imagePath)
                cell.imageView.kf.setImage(with: url)
            }
        case TVShowSections.cast.rawValue:
            if let imagePath = castList[indexPath.row].profile_path {
                let url = URL(string: TMDBAPI.baseImageURL + imagePath)
                cell.imageView.kf.setImage(with: url)
            }
        default:
            print("컬렉션 뷰 셀 - 이미지 설정 문제 생김")
            break
        }
        
        return cell
    }
}

// MARK: - UI Configuration Method

extension TVShowTableViewController {
    func render() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
