//
//  MessagesViewController.swift
//  Joke MessagesExtension
//
//  Created by Dmitri Nesterenko on 10/28/18.
//  Copyright © 2018 Pronounce. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var jokeCollectionView: UICollectionView!
    let reuseIdentifier = "cell"
    
    let jokes = Jokes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        jokes.getJokes(updateUI: bindData)
    }
    
    private func bindData(){
        print(jokes.jokes)
        self.jokeCollectionView.reloadData()
        self.jokeCollectionView.performBatchUpdates(nil, completion: {
            (result) in
            // ready
        })
        //jokeCollectionView.dataSource = jokes.jokes as? UICollectionViewDataSource
    }
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int{
        return self.jokes.jokes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! JokeViewCell
        let item = self.jokes.jokes[indexPath.item]
        
        cell.jokeText.text = String(format: "%.2f", item)
        
        
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath : IndexPath)
    {
        NSLog("You selected cell #\(indexPath.item)")
        
        
        ///Set the individual item state so we can track what the user is up to across
        ///all of the samples
        jokeCollectionView.reloadItems(at: [indexPath] as [IndexPath])
        
    }
    
   
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        //TODO: load jokes here
        //
       
    }
    
  
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
