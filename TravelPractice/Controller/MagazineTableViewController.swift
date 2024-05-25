//
//  MagazineTableViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

import Kingfisher

class MagazineTableViewController: UITableViewController {
    
    
    @IBOutlet weak var MagaineTableViewTitle: UILabel!
    
    var magazineList = MagazineList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 0
        
        MagaineTableViewTitle.text = "SeSAC TRAVEL"
        MagaineTableViewTitle.font = .boldSystemFont(ofSize: 20)
        MagaineTableViewTitle.textAlignment = .center
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return magazineList.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        
        let row = magazineList.getmagazine(at: rowIndex)
        
        print("[cell_\(rowIndex)]\n\(row)")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell
        
        if tableView.rowHeight == 0 {
            tableView.rowHeight = cell.frame.height
        }
        
        cell.selectionStyle = .default
        
        cell = setCellTitle(cell, text: row.title)
        cell = setCellSubTitle(cell, text: row.subtitle)
        cell = setCellDateLabel(cell, date: row.date, before: "yyMMdd", after: "yy년 MM월 d일")
        cell = setCellImage(cell, imageURL: row.photo_image)

        return cell
    }
    
    func setCellTitle(_ cell: MagazineTableViewCell, text: String) -> MagazineTableViewCell {
        cell.titleLabel.text = text
        cell.titleLabel.font = .boldSystemFont(ofSize: 20)
        cell.titleLabel.textAlignment = .left
        cell.titleLabel.numberOfLines = 0
        
        return cell
    }
    
    func setCellSubTitle(_ cell: MagazineTableViewCell, text: String) -> MagazineTableViewCell {
        cell.subtitleLabel.text = text
        cell.subtitleLabel.textColor = .systemGray3
        
        return cell
    }
    
    func setCellDateLabel(_ cell: MagazineTableViewCell, date: String, before: String, after: String) -> MagazineTableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateStyle = .long
        
        dateFormatter.dateFormat = before
        guard let newDate = dateFormatter.date(from: date) else {
            return cell
        }
        
        dateFormatter.dateFormat = after
        cell.dateLabel.text = dateFormatter.string(from: newDate)
        
        return cell
    }
    
    func setCellImage(_ cell: MagazineTableViewCell, imageURL: String) -> MagazineTableViewCell {
        guard let url = URL(string: imageURL) else {
            return cell
        }
        print(url)
        cell.travelImageView.kf.setImage(with: url)
        
//        cell.travelImageView.kf.indicatorType = .activity
//        cell.travelImageView.kf.setImage(
//            with: url,  // 이미지 불러올 url
//            placeholder: UIImage(systemName: "photo"),  // 이미지 없을 때의 이미지 설정
//            options: [
//                .processor(processor),
//                .scaleFactor(UIScreen.main.scale),
//                //.transition(.fade(1)),  // 애니메이션 효과
//                .cacheOriginalImage // 이미 캐시에 다운로드한 이미지가 있으면 가져오도록
//            ])
//        
        return cell
    }

}
