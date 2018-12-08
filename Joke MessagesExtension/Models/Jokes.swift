//
//  Messages.swift
//  Joke MessagesExtension
//
//  Created by Dmitri Nesterenko on 11/3/18.
//  Copyright © 2018 Pronounce. All rights reserved.
//

import Foundation
import Messages

class Jokes{
    let jokeURL = "https://icanhazdadjoke.com/search"
    var jokes = [String]()
    var urlSession:URLSession!
    var request:URLRequest!
    var dataTask: URLSessionDataTask!
    public init(){
        let url = URL(string: jokeURL)
        self.jokes.append("Knock, knock. Who's there? A breath of fresh air")
        request = URLRequest(url:url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    public func getJokes(updateUI: @escaping () -> ()){
        dataTask = urlSession.dataTask(with: request, completionHandler: {(data, response, error) in
            if ((error) != nil){
                return
            }
           
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let jokeArray = jsonObj!.value(forKey: "results") as? NSArray{
                    for joke in jokeArray{
                        if let jokeDict = joke as? NSDictionary{
                            if let jokeText = jokeDict.value(forKey: "joke"){
                                self.jokes.append((jokeText as? String)!)
                            }
                        }
                    }
                    
                }
                

                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    updateUI()
                })
                
            }
            })
        dataTask.resume()
    }
    
    private func showJokes(){
        //TODO bind it to a data source
        print(jokes)
    }
}
private func composeMessage() {
    let layout = MSMessageTemplateLayout()
    //TODO audio here
    layout.image = UIImage(named: "message-background.png")
    //
    layout.imageTitle = "iMessage Extension"
    //INSERT joke here
    layout.caption = "Hello world!"
    
    let message = MSMessage()
    message.shouldExpire = true
    message.layout = layout
}
