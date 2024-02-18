//
//  HomeViewController.swift
//  DogRun
//
//

import UIKit
import SnapKit
import OSLog

final class MainViewController: UIViewController {
    
    
    let navigationBar = UINavigationBar()
    let mainImageView =  UIImageView()
    let infoTableView = UITableView()
 
    let userId = AppConstants.dummyUserId
    var viewModel: MainViewModel?
    var mainInfo: MainInfo?
    private let service = APIService() 
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: AppConstants.daysOfWeek)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    
    private let rightBarButtonItem = UIBarButtonItem(title: "setting", style: .plain, target: self, action: #selector(rightBarButtonTapped))
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(persistenceService: service)
        layout()
        
        // 데이터 초기 요청
        retriveData(uid: userId)
    }

    private func layout() {
     
        let bgColor: UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        self.view.backgroundColor = bgColor
        navigationItem.rightBarButtonItem = rightBarButtonItem
        initImageView()
        initSegmentedCtl()
        initTableView()
    }
    
    private func retriveData(uid: String){
        viewModel?.retrieve(uid: uid) { success in
            if success {
                OSLog.message(.default, "retrieve done")
            } else {
                OSLog.message(.debug, "retrieve fail")
            }
        }
    }
}

// MARK: - layout sub methods
extension MainViewController{
    
    func initImageView(){
        
        mainImageView.image = UIImage(named: "profile")
        mainImageView.layer.cornerRadius = 100
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        mainImageView.layer.shadowOpacity = 0.7
        mainImageView.layer.shadowRadius = 5
        mainImageView.layer.shadowColor = UIColor.gray.cgColor
        
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.width.height.equalTo(200)
        }
        
    }
    
    func initSegmentedCtl(){
        
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(50)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    func initTableView(){
        
        view.addSubview(infoTableView)
        infoTableView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
}


// MARK: - click event (objc)
extension MainViewController{
     
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
