//
//  PhotoViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/19.
//
import UIKit
import SnapKit
import Photos

protocol PhotoViewControllerDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
} 

class PhotoViewController: UIViewController {
    
    var delegate: PhotoViewControllerDelegate? 
    var tableView: UITableView!
    var photos = [UIImage]()
    let cellId = "PhotoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        getAllPhotos()
    }
    
    
    private func layout(){
        setupNavigationBar()
        setupTableView()
    }
    
    
    private func getAllPhotos() {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                print("권한이 없습니다.")
                return
            }
            let fetchOptions = PHFetchOptions()
            let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            allPhotos.enumerateObjects { (asset, _, _) in
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image, _) in
                    if let image = image {
                        self.photos.append(image)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
   
  
}
// MARK: - click event
extension PhotoViewController{
    @objc func openGallery() {
        getAllPhotos()
    }
}


// MARK: - view init
extension PhotoViewController{
    
    func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhotoCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func setupNavigationBar() {
        // 네비게이션 바에 "갤러리 열기" 버튼 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openGallery))
    }
}

// MARK: - UITableViewDataSource
extension PhotoViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.imageView?.image = photos[indexPath.row]
        return cell
    }
    
}
// MARK: - UITableViewDelegate
extension PhotoViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 사용자가 삭제 버튼을 눌렀을 때의 동작
            photos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectImage(photos[indexPath.item])
        dismiss(animated: true, completion: nil)
    } 
}
 
 
 
