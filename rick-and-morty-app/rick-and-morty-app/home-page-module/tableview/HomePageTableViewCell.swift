//
//  HomePageTableViewCell.swift
//  rick-and-morty-app
//
//  Created by Ozcan Biyik on 31.03.2022.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {
    
    let characterImage: UIImageView = UIImageView()
    let characterName: UILabel = UILabel()
    let nameLabel: UILabel = UILabel()
    let locationLabel: UILabel = UILabel()
    let characterLocation: UILabel = UILabel()
    let idLabel: UILabel = UILabel()
    let characterID: UILabel = UILabel()
        
    enum Identifier: String{
        case custom = "OB"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.characterImage.layer.masksToBounds = true
        self.characterImage.layer.cornerRadius = 10
        self.characterImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        configure()
        
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    private func configure(){
        
        addSubview(characterImage)
        addSubview(nameLabel)
        addSubview(characterName)
        addSubview(locationLabel)
        addSubview(characterLocation)
        addSubview(idLabel)
        addSubview(characterID)
        
        characterName.textColor = .gray
        characterLocation.textColor = .gray
        characterID.textColor = .gray
        
        characterImage.snp.makeConstraints { (make) in
            make.height.equalTo(168)
            make.width.equalTo(362)
            make.top.equalToSuperview()
            //make.center.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { (make) in

            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(14)
    
        }
        
        characterName.snp.makeConstraints { (make) in
            
            make.left.equalTo(nameLabel.snp.right)
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(characterName.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(14)
        }
        
        characterLocation.snp.makeConstraints { (make) in
            make.left.equalTo(locationLabel.snp.right)
            make.top.equalTo(characterName.snp.bottom).offset(2)
            //make.center.equalTo(characterName)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(characterImage.snp.bottom).offset(8)
            make.right.equalTo(characterImage).offset(-50)
        }
        
        characterID.snp.makeConstraints { (make) in
            make.left.equalTo(idLabel.snp.right)
            make.top.equalTo(characterImage.snp.bottom).offset(8)

            
        }
        
    }
    
    
}

