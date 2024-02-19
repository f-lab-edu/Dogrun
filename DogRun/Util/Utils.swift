//
//  Utils.swift
//  DogRun
//
//

import UIKit
import Photos

struct Utils {
    
    // 미기입 시 alert 생성
    static func showAlert(message: String, vc: UIViewController) {
        let alert = UIAlertController(title: LocalizationKeys.alertTitle.rawValue.localized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizationKeys.alertConfirm.rawValue.localized, style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
    // 응답 코드 확인
    static func isSuccessResponse(code: Int?) -> Bool {
        guard let valid = code else { return false }
        return valid == ResponseStatus.success.rawValue
    }
    
    func getAllPhotos() {
        // 권한 확인
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                print("권한이 없습니다.")
                return
            }
            
            // 모든 사진 가져오기
            let fetchOptions = PHFetchOptions()
            let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            
            // 가져온 사진 처리
            allPhotos.enumerateObjects { (asset, _, _) in
                // 사진에 대한 처리
                // 예: 사진을 가져와서 사용하기
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image, _) in
                    // 이미지 처리
                    if let image = image {
                        // 가져온 이미지 사용하기
                    }
                }
            }
        }
    }
}
