//
//  HomeViewController.swift
//  DogRun
//
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    
    let navigationBar = UINavigationBar()
    let mainImageView =  UIImageView()
    let infoTableView = UITableView()
    
    let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.userInfo.rawValue)
    
    var mainInfo: MainInfo
    
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: AppConstants.daysOfWeek)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    
    private let rightBarButtonItem = UIBarButtonItem(title: "setting", style: .plain, target: self, action: #selector(rightBarButtonTapped))
    
    var viewModel: MainViewModel?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        initView()
    }

     private func layout() {
         
        let bgColor: UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        self.view.backgroundColor = bgColor
        [navigationBar, mainImageView,segmentedControl,infoTableView].forEach({view.addSubview($0)})

        self.mainImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.width.height.equalTo(200)
        }


        self.segmentedControl.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(50)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }

        self.infoTableView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
     }
    
    
    private func initView(){
         
        self.mainImageView.image = UIImage(named: "profile")
        self.mainImageView.layer.cornerRadius = 100
        self.mainImageView.clipsToBounds = true
        self.mainImageView.contentMode = .scaleAspectFill
        self.mainImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.mainImageView.layer.shadowOpacity = 0.7
        self.mainImageView.layer.shadowRadius = 5
        self.mainImageView.layer.shadowColor = UIColor.gray.cgColor
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        viewModel = MainViewModel(uid: userId ?? "")
        
        viewModel?.submitResult { [weak self] error in
            guard let error = error else {
                
                // TODO: response data init
                return
            }
        }
        
     }
   
}

// MARK: - click event (objc)
extension MainViewController {
     
    @objc func rightBarButtonTapped() {
    // 오른쪽 아이콘 탭 시 동작할 내용
        print("Right Bar Button Tapped")
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // 선택된 세그먼트에 따라 다른 컨텐츠를 표시하는 로직 추가
        let selectedIndex = sender.selectedSegmentIndex
        let selectedDayOfWeek = sender.titleForSegment(at: selectedIndex) ?? ""
        print("Selected Day of Week: \(selectedDayOfWeek)")
    }
}
