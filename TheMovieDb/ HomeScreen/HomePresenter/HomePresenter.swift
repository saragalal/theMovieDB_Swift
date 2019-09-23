//
//  HomePresenter.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/15/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

class HomePresenterImplementaion: HomePresenterProtocol {
  var viewProtocol: HomeViewProtocol?
    var modelProtocol: HomeModelProtocol?
    var actorArrayURL = "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc"
    var searchURL = "https://api.themoviedb.org/3/search/person?api_key=facd2bc8ee066628c8f78bbb7be41943&query="
    var requestURL = ""
    var pageNo = 1
    var detaisViewController : DetailsViewController?
   init (viewProtocol: HomeViewProtocol , modelProtocol: HomeModelProtocol){
        self.viewProtocol = viewProtocol
        self.modelProtocol = modelProtocol
    }
    
    func getActorsListCount() -> Int {
    if let arrayLength = modelProtocol?.returnArrayCount() {
          return arrayLength
        }
         return 0
  }
    
   func getSectionNumber() -> Int {
    return 1
    }
    
    func getCellContaint(at cellNumber: Int) -> Actor {
       if let actor = modelProtocol?.returnActor(at: cellNumber) {
            return actor
        }
        return Actor()
    }
    
    func getList(urlString: String) {
        modelProtocol?.requestActorList(urlStr: urlString, page: pageNo, completion: {result in
            if result == true {
                self.viewProtocol?.updateTableView()
            }
        })
    }
    
    func viewIsReady() {
        pageNo = 1
        requestURL = actorArrayURL
        getList(urlString: requestURL)
    }
    
    func searchIsPressed(text: String) {
        pageNo = 1
        requestURL = searchURL+text
        getList(urlString: requestURL)
    }
    
    func refeshList() {
        removeDataFromTableView()
        self.pageNo = 1
        requestURL = actorArrayURL
        getList(urlString: requestURL)
    }
    func cancelSearchButtonIsPressed() {
       pageNo = 1
        requestURL = actorArrayURL
        getList(urlString: requestURL)
    }
    func removeDataFromTableView() {
        modelProtocol?.removeData()
        viewProtocol?.updateTableView()
    }
    func loadNextPage() {
        if pageNo < 500{
        pageNo += 1
        getList(urlString: requestURL)
        }
    }
    
    func cellISSelected(at cell: Int) {
        if let nextView = self.viewProtocol?.instatiateDetailsView(){
            self.detaisViewController = nextView
            if let actorSelected = modelProtocol?.returnActor(at: cell){
                let detailsModel: DetailsModelProtocol = DetailsModel(actor: actorSelected)
                nextView.detailsPresenter = DetailsPresenterImplementation(detailsView: nextView, detailsModel: detailsModel)
                self.viewProtocol?.naviagteToDetails(detailsView: nextView)
            }
        }
    }
}
