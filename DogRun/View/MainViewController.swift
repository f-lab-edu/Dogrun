//
//  HomeViewController.swift
//  DogRun
//
//
import OSLog
import SnapKit
import UIKit

final class MainViewController: UIViewController {
    let navigationBar = UINavigationBar()
    let mainImageView =  UIImageView()
    let infoTableView = UITableView()
    var viewModel: MainViewModel?
    private let segmentedControl = UISegmentedControl.custom(target: self, action: #selector(segmentedControlValueChanged(_:)))
    private let settingButton = UIBarButtonItem.custom(title: "setting", target: self, action: #selector(rightBarButtonTapped))

    override func viewDidLoad() {
        super.viewDidLoad()
        initView() // view 초기값 설정
        layout() // 레이아웃 const
        initVM() // viewmodel 초기설정
        initData() // 데이터 요청
    }
    private func initView() {
        initBackground()
        initImage()
    }
    private func layout() {
        constImage()
        constSegCtl()
        constTableView()
    }
    private func retriveData(uid: String) {
        viewModel?.retrieve(uid: uid) { success in
            if success {
                OSLog.message(.default, "retrieve done")
            } else {
                OSLog.message(.debug, "retrieve fail")
            }
        }
    }
}
// MARK: - init
extension MainViewController {
    private func initData() {
        // 데이터 초기 요청
        retriveData(uid: AppConstants.dummyUserId)
    }
    private func initVM() {
        let stub = NetworkManagerStub()
        stub.setTestData(from: "maininfo_mock")
        viewModel = MainViewModel(persistenceService: APIServiceStub(networkManager: stub),
                                  userDefaultService: MainInfoService())
    }
    private func initBackground() {
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = settingButton
    }
    private func initImage() {
        mainImageView.image = UIImage(named: "bongbong1")
        mainImageView.layer.cornerRadius = 100
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        mainImageView.layer.shadowOpacity = 0.7
        mainImageView.layer.shadowRadius = 5
        mainImageView.layer.shadowColor = UIColor.gray.cgColor
    }
}

// MARK: - layout sub methods
extension MainViewController {
    private func constImage() {
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.width.height.equalTo(200)
        }
    }
    private func constSegCtl() {
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(50)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    private func constTableView() {
        view.addSubview(infoTableView)
        infoTableView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
// MARK: - click event (objc)
extension MainViewController {
    @objc func rightBarButtonTapped() {
    // 오른쪽 아이콘 탭 시 동작할 내용
        let userInfoView = UserInfoViewController()
        self.navigationController?.setViewControllers([userInfoView], animated: true)
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // 선택된 세그먼트에 따라 다른 컨텐츠를 표시하는 로직 추가
        let selectedIndex = sender.selectedSegmentIndex
        let selectedDayOfWeek = sender.titleForSegment(at: selectedIndex) ?? ""
        // 데이터 요청 추가 예정 (feature/retrive-walk-info)
        OSLog.message(.debug, "\(selectedDayOfWeek)")
    }
}
