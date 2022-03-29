//
//  HomePageViewController.swift
//  rick-and-morty-app
//
//  Created by Ozcan Biyik on 29.03.2022.
//

import UIKit
import SnapKit

final class HomePageViewController: UIViewController {
    // build performansı için ve class türetilmesin(inherit) diye final ekledik.
    
    private let labelTitle: UILabel = UILabel()
    // dışardan gelmeyi engellemek için private ile kapatıyoruz.
    private let box: UIView = UIView()
    private let menu: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        view.addSubview(labelTitle)
        view.addSubview(box)
        view.addSubview(menu)
        
        view.backgroundColor = .white
        box.backgroundColor = .red
        labelTitle.text = "Rick & Morty"
        menu.backgroundColor = .lightGray
        menu.setTitle(".", for: .normal)
        
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)// padding soldan 10 ekledik
            make.height.greaterThanOrEqualTo(10)
        }
        
        menu.snp.makeConstraints { (make) in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
        
        box.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
        
        
    }

}
