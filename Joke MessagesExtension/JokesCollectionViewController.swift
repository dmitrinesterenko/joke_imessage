//
//  JokesViewController.swift
//  Joke MessagesExtension
//
//  Created by Dmitri Nesterenko on 12/1/18.
//  Copyright © 2018 Pronounce. All rights reserved.
//

import Foundation
import UIKit

protocol JokesCollectionViewControllerDelegate: class {
    func didSelectJokeItem(_ item: String)
}

class JokesCollectionViewController: UICollectionViewController{
    
    @IBOutlet var jokeCollectionView: UICollectionView!
    
    var delegate: JokesCollectionViewControllerDelegate?
    
    let reuseIdentifier = "Joke Cell"
    let jokes = Jokes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(false)
        jokes.getJokes(updateUI: bindData)
    }
    
    private func bindData(){
        print(jokes.jokes)
        DispatchQueue.main.async{
            self.jokeCollectionView.reloadData()
        }
        
    }
    // MARK: - UICollectionViewDataSource protocol
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int{
        return self.jokes.jokes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! JokeViewCell
        let item = self.jokes.jokes[indexPath.item]
        cell.jokeText.text = item

        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath : IndexPath)
    {
        NSLog("You selected cell #\(indexPath.item)")
        let joke = self.jokes.jokes[indexPath.row]
        delegate?.didSelectJokeItem(joke)
       
        
    }
    
}
