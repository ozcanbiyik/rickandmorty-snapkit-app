//
//  HomePageViewController.swift
//  rick-and-morty-app
//
//  Created by Ozcan Biyik on 29.03.2022.
//

import UIKit
import SnapKit
import Apollo
import Kingfisher

final class RickPageViewController: UIViewController {
    
    private let labelTitle: UILabel = UILabel()
    private var tableView: UITableView = UITableView()
    private let menu: UIButton = UIButton()
    private let icon = UIImage(named: "filter")
    
    var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
    var launches = [RickListQuery.Data.Character.Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.apollo.fetch(query: RickListQuery()) { result in
            switch result{
            case .success(let graphqlResult):
                if let launches = graphqlResult.data?.characters?.results?.compactMap({ $0 }){
                    self.launches.append(contentsOf: launches)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        configure()
    }
    
    
    
    private func configure(){
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(menu)
        
        drawDesign()
        makeLabel()
        makeTableView()
        makeMenu()
    }
    
    private func drawDesign(){
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RickPageTableViewCell.self, forCellReuseIdentifier: RickPageTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 265
        
        DispatchQueue.main.async { [self] in
            self.view.backgroundColor = .white
            let titleString = "Rick"
            self.labelTitle.font = UIFont.boldSystemFont(ofSize: 24)
            self.labelTitle.text = titleString
            self.menu.setImage(self.icon, for: .normal)
            self.menu.imageView?.contentMode = .scaleAspectFit
            self.menu.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
            self.menu.tag = 1

        }
        
    }
    
    @objc func buttonAction(sender: UIButton!){
        let btnTag: UIButton = sender
        if btnTag.tag == 1 {
            let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "Rick", style: .default) { (action) in
                let vcRick = RickPageViewController() //change this to your class name
                vcRick.modalPresentationStyle = .fullScreen
                self.present(vcRick, animated: true, completion: nil)
            }
            let action2 = UIAlertAction(title: "Morty", style: .default) { (action) in
                let vcMorty = MortyPageViewController() //change this to your class name
                vcMorty.modalPresentationStyle = .fullScreen
                self.present(vcMorty, animated: true, completion: nil)
            }
            ac.addAction(action1)
            ac.addAction(action2)
            present(ac, animated: true)
        }
    }
   
}

extension RickPageViewController{
    
    private func makeLabel(){
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    
    private func makeTableView(){
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalTo(view)
            
        }
    }
    
    private func makeMenu(){
        menu.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle).offset(4)
            make.right.equalTo(labelTitle).offset(100)
        }

    }
    
}

extension RickPageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickPageTableViewCell.Identifier.custom.rawValue) as? RickPageTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.1
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        cell.backgroundColor = .white
        cell.nameLabel.text = "Name: "
        cell.characterName.text = launches[indexPath.row].name!
        cell.characterImage.kf.setImage(with: URL(string: launches[indexPath.row].image!))
        cell.locationLabel.text = "Location: "
        cell.characterLocation.text = "\(launches[indexPath.row].location!.name ?? "Earth")"
        cell.idLabel.text = "#id: "
        cell.characterID.text = "\(launches[indexPath.row].id!)"
        return cell
    }
    
    
}

