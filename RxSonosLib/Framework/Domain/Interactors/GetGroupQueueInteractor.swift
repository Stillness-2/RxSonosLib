//
//  GetGroupQueueInteractor.swift
//  RxSonosLib
//
//  Created by Stefan Renne on 04/04/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import Foundation
import RxSwift

class GetGroupQueueValues: RequestValues {
    let group: Group
    
    init(group: Group) {
        self.group = group
    }
}

class GetGroupQueueInteractor: Interactor {
    
    private let contentDirectoryRepository: ContentDirectoryRepository
    
    init(contentDirectoryRepository: ContentDirectoryRepository) {
        self.contentDirectoryRepository = contentDirectoryRepository
    }
    
    func buildInteractorObservable(requestValues: GetGroupQueueValues?) -> Observable<[MusicProviderTrack]> {
        
        guard let masterRoom = requestValues?.group.master else {
            return Observable.error(NSError.sonosLibInvalidImplementationError())
        }
        
        return createTimer(SonosSettings.shared.renewGroupQueueTimer)
            .flatMap(self.mapToQueue(for: masterRoom))
            .distinctUntilChanged()
    }
    
    fileprivate func mapToQueue(for masterRoom: Room) -> ((Int) -> Observable<[MusicProviderTrack]>) {
        return { _ in
            return self.contentDirectoryRepository
                .getQueue(for: masterRoom)
                .asObservable()
        }
    }
}
