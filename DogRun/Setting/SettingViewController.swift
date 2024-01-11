//
//  SettingViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/05.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
       
    }
    
    
    
     
   
   private func initView(){
       
       let settingList = ["설정1","설정2","설정3","설정4","설정5",]
        
       // 5개의 셀을 생성하여 UIViewController에 추가
        for i in 0..<5 {
            let customCellView = SettingViewCell()
            view.addSubview(customCellView)

            // Snapkit으로 CustomCellView의 제약 조건 설정 (넓이를 화면 전체로 설정, 높이는 그대로 유지)
            customCellView.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20 + i * 60) // 예시로 상단 여백 및 각 셀의 세로 간격 설정
                $0.leading.trailing.equalToSuperview() // 화면 전체의 넓이로 설정
                $0.height.equalTo(50) // 높이는 그대로 설정
            }

            // CustomCellView에 데이터 설정
            customCellView.configure(with: settingList[i])
            // 클릭 이벤트 처리 클로저 설정
            customCellView.onClick = {
                
            
                let aa = settingList[i]
                switch aa {
                    case "설정1":
                        // i가 0일 때의 처리
                        let view = UserInfoViewController()
                        //  self.present(view, animated: true, completion: nil)
                    self.navigationController?.setViewControllers([view], animated: true)

                    case "설정2":
                        // i가 1일 때의 처리
                        let view = DogInfoViewController()
                          self.present(view, animated: true, completion: nil)

                    case "설정3":
                        // i가 2일 때의 처리
                        let view = HomeViewController()
                         self.present(view, animated: true, completion: nil)

                    
                    case "설정4":
                        // i가 2일 때의 처리
                        let view = ViewController()
                         self.present(view, animated: true, completion: nil)

                        
                    case "설정5":
                        // i가 2일 때의 처리
                        let view = SettingViewController()
                          self.present(view, animated: true, completion: nil)

                    default:
                        return
                }
            }




        }
       
   }
    
    
}
