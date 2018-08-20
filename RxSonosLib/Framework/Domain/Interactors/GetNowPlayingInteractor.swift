//
//  GetNowPlayingInteractor.swift
//  Demo App
//
//  Created by Stefan Renne on 26/03/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import Foundation
import RxSwift

class GetNowPlayingValues: RequestValues {
    let group: Group
    
    init(group: Group) {
        self.group = group
    }
}

class GetNowPlayingInteractor<R: GetNowPlayingValues>: Interactor {
    
    let transportRepository: TransportRepository
    
    init(transportRepository: TransportRepository) {
        self.transportRepository = transportRepository
    }
    
    func buildInteractorObservable(requestValues: GetNowPlayingValues?) -> Observable<Track?> {
        
        guard let masterRoom = requestValues?.group.master else {
            return Observable.error(NSError.sonosLibInvalidImplementationError())
        }
        
        return createTimer(SonosSettings.shared.renewNowPlayingTimer)
            .flatMap(self.mapToTrack(for: masterRoom))
            .distinctUntilChanged({ lhs, rhs in
                guard let lhs = lhs, let rhs = rhs, lhs.uri == rhs.uri else { return false }
                return true
            })
    }
    
    fileprivate func mapToTrack(for masterRoom: Room) -> ((Int) -> Observable<Track?>) {
        return { _ in
            return self.transportRepository
                .getNowPlaying(for: masterRoom)
        }
    }
}
