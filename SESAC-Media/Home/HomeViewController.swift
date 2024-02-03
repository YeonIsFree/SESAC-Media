//
//  ViewController.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import UIKit
import Kingfisher
import SnapKit

class HomeViewController: UIViewController {
    
    let titleList: [String] = ["Trend", "Top Rated", "Popular"]
     
    var seriesData: [[TVSeries]] = [[], [], []]
    
     // MARK: - UI Property
    
    let tvTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        render()
        
        let group = DispatchGroup()
        
        // Trend
        group.enter()
        DispatchQueue.global().async {
            TMDBAPIManager.shared.fetchData(type: TVSeriesModel.self, api: .trend) { list in
                self.seriesData[HomeSections.trend.sectionNumber] = list.results
            }
            group.leave()
        }

        // Top Rated
        group.enter()
        DispatchQueue.global().async {
            TMDBAPIManager.shared.fetchData(type: TVSeriesModel.self, api: .topRated) { list in
                self.seriesData[HomeSections.topRated.sectionNumber] = list.results
            }
            group.leave()
        }
   
        // Popular
        group.enter()
        DispatchQueue.global().async {
            TMDBAPIManager.shared.fetchData(type: TVSeriesModel.self, api: .popular) { list in
                self.seriesData[HomeSections.popular.sectionNumber] = list.results
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tvTableView.reloadData()
        }
    }
}

 // MARK: - UITableView Delegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tvTableView.dequeueReusableCell(withIdentifier: TvTableViewCell.identifier, for: indexPath) as? TvTableViewCell else { return UITableViewCell() }
        
        // configure showCollectionView
        cell.showCollectionView.delegate = self
        cell.showCollectionView.dataSource = self
        cell.showCollectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: ShowCollectionViewCell.identifier)
        
        // 테이블 뷰 셀 각각의 title 설정
        cell.titleLabel.text = titleList[indexPath.row]
        
        // 테이블 뷰 셀에 들어있는 컬렉션 뷰에 tag 설정
        cell.showCollectionView.tag = indexPath.row
        
        cell.showCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }
}

 // MARK: - UITableView Configuration Method

extension HomeViewController {
    func configureTableView() {
        tvTableView.dataSource = self
        tvTableView.delegate = self
        tvTableView.register(TvTableViewCell.self, forCellReuseIdentifier: TvTableViewCell.identifier)
    }
}

 // MARK: - UICollectionView Delegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = collectionView.tag
        return seriesData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell else { return UICollectionViewCell() }
        
        // 각 테이블 뷰에 들어있는 컬렉션 뷰 구성
        let section = collectionView.tag
        let item = seriesData[section][indexPath.row]
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(item.poster_path ?? "")") {
            cell.showImageView.kf.setImage(with: url)
        } else { print("뭔가 잘못됐다!") }
        
        return cell
    }
}

 // MARK: - UI Configuration Method

extension HomeViewController {
    func render() {
        view.addSubview(tvTableView)
        tvTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
