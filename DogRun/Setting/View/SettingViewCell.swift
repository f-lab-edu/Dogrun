//
//  SettingViewCell.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/06.
//

import UIKit


class SettingViewCell: UIView {
    
    // UILabel을 나타낼 프로퍼티
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.layoutMargins.left = 16
        return label
    }()
    
    // 셀 아래에 추가할 회색 줄을 나타낼 프로퍼티
       private let separatorView: UIView = {
           let view = UIView()
           view.backgroundColor = .gray
           return view
       }()
    
    // 클릭 이벤트를 처리할 클로저 프로퍼티
    var onClick: (() -> Void)?
    
    // 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UIView에 UILabel을 추가
        addSubview(label)
        addSubview(separatorView)
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview() // UILabel을 UIView와 같은 크기로 설정
            $0.leading.equalToSuperview().offset(16)
        }

        // UIView에 회색 줄을 추가
        separatorView.snp.makeConstraints { make in
           make.leading.trailing.bottom.equalToSuperview() // 아래에 붙이기
           make.height.equalTo(1) // 높이 설정
        }
        
        // UITapGestureRecognizer를 추가하여 클릭 이벤트 처리
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapGesture)
        
        // 사용자 상호 작용이 가능하도록 설정
        isUserInteractionEnabled = true
    }
    
    // UILabel의 텍스트를 설정하는 메서드
    func configure(with text: String) {
        label.text = text
    }
    
    // UITapGestureRecognizer에 의해 호출될 메서드
    @objc private func cellTapped() {
    // 클릭 이벤트를 처리하는 클로저 실행
        onClick?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
