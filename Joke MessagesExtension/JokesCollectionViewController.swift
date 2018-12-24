//
//  JokesViewController.swift
//  Joke MessagesExtension
//
//  Created by Dmitri Nesterenko on 12/1/18.
//  Copyright © 2018 Pronounce. All rights reserved.
//

import Foundation
import UIKit
class JokesCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var jokeCollectionView: UICollectionView!
    let reuseIdentifier = "Joke Cell"
    
    let jokes = Jokes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(false)
        jokes.getJokes(updateUI: bindData)
    }
    
    private func bindData(){
        print(jokes.jokes)
        jokeCollectionView.dataSource = jokes.jokes as? UICollectionViewDataSource
    }
    // MARK: - UICollectionViewDataSource protocol
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int{
        return self.jokes.jokes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! JokeViewCell
        let item = self.jokes.jokes[indexPath.item]
        cell.jokeText = UILabel()
        cell.jokeText.text = String(format: "%s", item)
        
        
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath : IndexPath)
    {
        NSLog("You selected cell #\(indexPath.item)")
        
        
        ///Set the individual item state so we can track what the user is up to across
        ///all of the samples
        jokeCollectionView.reloadItems(at: [indexPath] as [IndexPath])
        
    }
    
}
