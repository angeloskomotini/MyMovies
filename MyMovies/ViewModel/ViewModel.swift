import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class ViewModel{
    
    private var mymovies = MyMovieHomeScreen()
    
    var id:String{
        return mymovies.id!
    }
    var poster:String{
        return mymovies.poster!
    }
    var title:String{
        return mymovies.title!
    }
    var releasedate:String{
        return mymovies.releasedate!
    }
    var rating:String{
        return mymovies.rating!
    }
    var status:String{
        return mymovies.rating!
    }
    var overViewFilm:String{
        return mymovies.overViewFilm!
    }
    var votes:String{
        return mymovies.votes!
    }
    var genre:String{
        return mymovies.genre!
    }
    
    func updateid(movieid:String){
        mymovies.id = movieid
    }
    func updateposter(movieposter:String){
        mymovies.poster = movieposter
    }
    func updatetitle(movietitle:String){
        mymovies.title = movietitle
    }
    func updatereleasedate(moviereleasedate:String){
        mymovies.releasedate = moviereleasedate
    }
    func updaterating(movierating:String){
        mymovies.rating = movierating
    }
    func updatestatus(moviestatus:String){
        mymovies.status = moviestatus
    }
    func updateoverviewFilm(movieoverviewfilm:String){
        mymovies.overViewFilm = movieoverviewfilm
    }
    func updatevote(movievote:String){
        mymovies.votes = movievote
    }
    func ListSearchResults(searchString:String,result:@escaping (([MyMovieHomeScreen])->())){
        let url = urlSearchResults(searchString: searchString)
        let request = URLRequest(url: url)
        Alamofire.request(request as URLRequestConvertible).responseJSON { (response) in
            let jsonObj = JSON(response.result.value!)
            for resultItem in jsonObj["results"].arrayValue{
                var homeScreen=[MyMovieHomeScreen]()
                self.updateid(movieid: resultItem["id"].stringValue)
                let poster=resultItem["poster_path"].stringValue
                let path=String("http://image.tmdb.org/t/p/w185")+String(poster )
                self.updateposter(movieposter: path)
                self.updatetitle(movietitle:resultItem["title"].stringValue)
                self.updatereleasedate(moviereleasedate: resultItem["release_date"].stringValue)
                self.updaterating(movierating: resultItem["vote_average"].stringValue)
                
                homeScreen.append(self.self.mymovies)
                result(homeScreen)
            }
        }
    }
    func urlSearchResults(searchString:String)->URL{
        return URL(string: "https://api.themoviedb.org/3/search/movie?api_key=6b2e856adafcc7be98bdf0d8b076851c&language=en-US&query="+searchString+"&page=1&include_adult=false")!
    }
    func urlDetailsScreen(id:String)->String{
        return "https://api.themoviedb.org/3/movie/"+String(id)+"?api_key=6b2e856adafcc7be98bdf0d8b076851c"
    }
    func ListDetailsScreen(id:String,result:@escaping (([MyMovieHomeScreen])->())){
        let manager = AFHTTPSessionManager()
        manager.get(urlDetailsScreen(id: id),parameters:nil, progress: nil, success: { (data, response) in
            let responseJSON = response as! [String:Any]
            let jsonObj = JSON(responseJSON)
            var detailScreen=[MyMovieHomeScreen]()
            let poster = jsonObj["poster_path"].stringValue
            let path=String("http://image.tmdb.org/t/p/w185")+String(poster)
            self.updateid(movieid: jsonObj["id"].stringValue)
            self.updateposter(movieposter: path)
            self.updatetitle(movietitle:jsonObj["title"].stringValue)
            self.updatereleasedate(moviereleasedate: jsonObj["release_date"].stringValue)
            self.updaterating(movierating: jsonObj["vote_average"].stringValue)
            self.updateoverviewFilm(movieoverviewfilm:jsonObj["overview"].stringValue)
            detailScreen.append(self.self.mymovies)
            result(detailScreen)
        }) { (data, error) in
            debugPrint(error.localizedDescription)
        }
    }
    
    
    
    
}
