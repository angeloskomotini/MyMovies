import Foundation
import UIKit

class ViewModel{
    
    let requests = Requests()
        
    func ListDetailsScreen(detailsScreen:MovieDetailsScreenViewController){
            self.requests.ListDetailsScreen(id:detailsScreen.getID!,result: {
            result in
                detailsScreen.dTitle.text=result[0].title
                detailsScreen.poster.downloaded(from: result[0].poster!)
                detailsScreen.releaseDate.text=result[0].releasedate
                detailsScreen.overview.text=result[0].overview
                detailsScreen.status.text=result[0].status
                detailsScreen.genre.text=result[0].genre
                if let rating=result[0].rating{
                    let convertValue = Double(rating)
                    detailsScreen.rating.rating = convertValue! / 2.0
                    
                }
            })
        
    }
    
    func ListPopularMovies(homeScreen:MainTableViewController){
            self.requests.ListPopularMovies(result: {
            result in
            for countResults in 0..<result.count {
                    homeScreen.results.append(result[countResults])
                }
                DispatchQueue.main.async{
                    homeScreen.tableView.reloadData()
                }
            })
    }
    
    func ListSearchResults(homeScreen:MainTableViewController){
        homeScreen.results.removeAll()
        requests.ListSearchResults(searchString:homeScreen.searchString!,result: {
            result in
            for countResults in 0..<result.count {
                homeScreen.results.append(result[countResults])
            }
            DispatchQueue.main.async{
                homeScreen.tableView.reloadData()
            }
        })
    }
}
