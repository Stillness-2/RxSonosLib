//
//  GetGroupsInteractor.swift
//  RxSonosLib
//
//  Created by Stefan Renne on 02/03/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import Foundation
import RxSwift
import RxSSDP

struct GetGroupsValues: RequestValues {
    let rooms: BehaviorSubject<[Room]>
}

class GetGroupsInteractor: ObservableInteractor {
    
    var requestValues: GetGroupsValues?
    
    private let groupRepository: GroupRepository
    
    init(groupRepository: GroupRepository) {
        self.groupRepository = groupRepository
    }
    
    func buildInteractorObservable(values: GetGroupsValues?) -> Observable<[Group]> {
        return createTimer(SonosSettings.shared.renewGroupsTimer)
            .flatMap(mapRoomsToGroups(roomSubject: requestValues?.rooms))
            .distinctUntilChanged()
    }
    
    /* Groups */
    fileprivate func mapRoomsToGroups(roomSubject: BehaviorSubject<[Room]>?) -> ((Int) throws -> Observable<[Group]>) {
        return { _ in
            guard let rooms = try roomSubject?.value() else {
                return Observable.just([])
            }
            
            return self.groupRepository
                .getGroups(for: rooms)
                .asObservable()
        }
    }
}
