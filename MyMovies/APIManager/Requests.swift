import Foundation
import Alamofire
import SwiftyJSON
class Requests{
    func ListDetailsScreen(id:Int,result:@escaping (([MyMovieHomeScreen])->())){
        let url = URL(string: "https://api.themoviedb.org/3/movie/"+String(id)+"?api_key=c5cb514722d0000773d91a41ec5c1c1b")!
        let request = URLRequest(url: url)
        Alamofire.request(request as URLRequestConvertible).responseJSON { (response) in
            var jsonObj = JSON(response.result.value!)
            var detailScreen=[MyMovieHomeScreen]()
            let myMovie = MyMovieHomeScreen()
            myMovie.id = jsonObj["id"].intValue
            let poster = jsonObj["poster_path"].stringValue
            let path=String("http://image.tmdb.org/t/p/w185/")+String(poster )
            myMovie.poster = path
            myMovie.title = jsonObj["title"].stringValue
            myMovie.votes = jsonObj["vote_count"].stringValue
            myMovie.status = jsonObj["status"].stringValue
            myMovie.overview=jsonObj["overview"].stringValue
            myMovie.releasedate=jsonObj["release_date"].stringValue
            myMovie.rating=jsonObj["vote_average"].stringValue
            myMovie.genre = jsonObj["genres"][0]["name"].stringValue
            detailScreen.append(myMovie)
            result(detailScreen)
        }
     
    }
    func ListPopularMovies(result:@escaping (([MyMovieHomeScreen])->())){
         let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=c5cb514722d0000773d91a41ec5c1c1b&language=en-US&page=1")!
         let request = URLRequest(url: url)
        Alamofire.request(request as URLRequestConvertible).responseJSON { (response) in
                var jsonObj = JSON(response.result.value!)
                for resultItem in jsonObj["results"].arrayValue{
                    var homeScreen=[MyMovieHomeScreen]()
                    let myMovie = MyMovieHomeScreen()
                    myMovie.id = resultItem["id"].intValue
                    let poster=resultItem["poster_path"].stringValue
                    let path=String("http://image.tmdb.org/t/p/w185/")+String(poster )
                    myMovie.poster=path
                    myMovie.title=resultItem["title"].stringValue
                    myMovie.releasedate=resultItem["release_date"].stringValue
                    myMovie.rating=resultItem["vote_average"].stringValue
                    homeScreen.append(myMovie)
                    result(homeScreen)
                }
        }
    }
    func ListSearchResults(searchString:String,result:@escaping (([MyMovieHomeScreen])->())){
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=c5cb514722d0000773d91a41ec5c1c1b&language=en-US&query="+searchString+"&page=1&include_adult=false")!
        let request = URLRequest(url: url)
        Alamofire.request(request as URLRequestConvertible).responseJSON { (response) in
            var jsonObj = JSON(response.result.value!)
            for resultItem in jsonObj["results"].arrayValue{
                var homeScreen=[MyMovieHomeScreen]()
                let myMovie = MyMovieHomeScreen()
                let poster=resultItem["poster_path"].stringValue
                let path=String("http://image.tmdb.org/t/p/w185/")+String(poster )
                myMovie.poster=path
                myMovie.title=resultItem["title"].stringValue
                myMovie.releasedate=resultItem["release_date"].stringValue
                myMovie.rating=resultItem["vote_average"].stringValue
                homeScreen.append(myMovie)
                result(homeScreen)
            }
        }
    }
    
}

