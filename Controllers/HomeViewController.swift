//
//  HomeViewController.swift
//  Twitter
//
//  Created by Jennifer Chukwuemeka on 06/11/2022.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
    private var subscription: Set<AnyCancellable> = []
    private var viewModel = HomeViewViewModel()
    
    private func ConfigureNavigationBar() {
        let size: CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "twitterLogo")
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
        
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
    }
    
    @objc private func didTapProfile() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private let timeLineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timeLineTableView)
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        ConfigureNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
        bindViews()

        
    }
    
    @objc private func didTapSignOut() {
       try? Auth.auth().signOut()
        handleAuthenication()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTableView.frame = view.frame
    }
    private func handleAuthenication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: onBoardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthenication()
        viewModel.retreivUser()
        
        
    }
    
    func completeUseronboarding() {
        let vc = ProfileDataFormViewController()
        present(vc, animated: true)
        
    }
    
    func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else {return}
            if !user.isUserOnboarded {
                self?.completeUseronboarding()
                
            }
        }
        .store(in: &subscription)

        
    }
    

   

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
            
        }
        cell.delegate = self
        return cell
                
    }

    
    
}

extension HomeViewController: TweetTableViewCellDelegate {
    func TweetTableViewCellDidTapReply() {
        print("reply")
    }
    
    func TweetTableViewCellDidTapRetweet() {
        print("twet")
    }
    
    func TweetTableViewCellDidTapLike() {
        print("like")
    }
    
    func TweetTableViewCellDidTapShare() {
        print("share")
    }
    
    
}
