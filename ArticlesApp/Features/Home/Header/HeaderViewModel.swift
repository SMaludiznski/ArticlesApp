//
//  HeaderViewModel.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 11/02/2022.
//

import Foundation
import RxSwift

final class HeaderViewModel {
    private let disposeBag = DisposeBag()
    let temperature = PublishSubject<Int>()
    
    init() {
        getUserLocation()
    }
    
    private func getUserLocation() {
        LocationManager.shared.getUserLocation { [weak self] location in
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self?.downloadWeather(lat: lat, lon: lon)
        }
    }
    
    private func downloadWeather(lat: Double, lon: Double) {
        let observable: Observable<WeatherApiResponse> = NetworkEngine.downloadData(endpoint: WeatherEndpoint.fetchWeatherFrom(lat: lat, lon: lon))

        observable
            .subscribe(onNext: { weather in
                let temp = Int(round(weather.main.temp))
                self.temperature.onNext(temp)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
