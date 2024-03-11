//
//  WalkViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/03/11.
//
 
import UIKit
import CoreMotion
import OSLog

class WalkViewController: UIViewController {
     
    let label = UILabel()
    let button1 = UIButton()
    let button2 = UIButton()
    
    let coreService = CoreMotionService()
    var mySteps: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        coreService.stepUpdateHandler = { steps in
            DispatchQueue.main.async { // 메인 스레드에서 실행
                Utils.showToast("지금까지 \(steps)보 걸었습니다", withDuration: 2, delay: 1, vc: self)
                self.mySteps = steps
                self.updateLabel()
            }
        }
    }
     
    private func layout() {
        setupViews()
        setupButtonActions()
        setConstraints()
    }
}

// MARK: - click events
extension WalkViewController{
    
    @objc private func startBtnTapped() {
        // 버튼 1이 클릭되었을 때 수행할 동작 추가
        Utils.showToast("산책 시작!", withDuration: 2, delay: 1, vc: self)
        coreService.startScheduler()
    }
     
    @objc private func endBtnTapped() {
        // 버튼 2가 클릭되었을 때 수행할 동작 추가
        Utils.showToast("산책이 종료되었습니다", withDuration: 2, delay: 1, vc: self)
        coreService.stopScheduler()
        mySteps = 0
        updateLabel()
    }
}

// MARK: - init
extension WalkViewController{
    
    private func updateLabel() {
        label.text = "- \(mySteps)"
    }
}

// MARK: - view sub methods
extension WalkViewController{
    
    
    private func setupViews() {
        // Label 설정
        label.text = "- \(mySteps)"
        view.addSubview(label)
        
        // Button1 설정
        button1.setTitle("Button 1", for: .normal)
        button1.setTitleColor(.blue, for: .normal)
        button1.layer.borderWidth = 1 // 테두리 두께
        button1.layer.borderColor = UIColor.black.cgColor // 테두리 색상
        view.addSubview(button1)
        
        // Button2 설정
        button2.setTitle("Button 2", for: .normal)
        button2.setTitleColor(.blue, for: .normal)
        button2.layer.borderWidth = 1 // 테두리 두께
        button2.layer.borderColor = UIColor.black.cgColor // 테두리 색상
        view.addSubview(button2)
    }
     
    private func setupButtonActions() {
        button1.addTarget(self, action: #selector(startBtnTapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(endBtnTapped), for: .touchUpInside)
    }
    
    private func setConstraints(){
        // Label Constraints
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }

        // Button1 Constraints
        button1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
            $0.width.equalTo(100) // 버튼의 너비 설정
            $0.height.equalTo(50) // 버튼의 높이 설정
        }

        // Button2 Constraints
        button2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button1.snp.bottom).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
    }
}
