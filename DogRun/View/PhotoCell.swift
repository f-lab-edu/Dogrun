//
//  PhotoCell.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/19.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    var photoImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(200) // 이미지 뷰의 크기 설정
        }
    }
}
