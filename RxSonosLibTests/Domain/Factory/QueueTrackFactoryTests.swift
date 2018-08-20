//
//  QueueTrackFactoryTests.swift
//  RxSonosLibTests
//
//  Created by Stefan Renne on 03/05/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import RxSonosLib

class QueueTrackFactoryTests: XCTestCase {
    
    func testItCanCreateSpotifyTrack() {
        let data = ["resduration": "0:03:56", "resprotocolInfo": "sonos.com-spotify:*:audio/x-spotify:*", "class": "object.item.audioItem.musicTrack", "album": "Time For Annihilation: On the Record & On the Road", "res": "x-sonos-spotify:spotify%3atrack%3a0Vh1sTeybmGy8Kxl2vw0Ye?sid=9&flags=8224&sn=1", "albumArtURI": "/getaa?s=1&u=x-sonos-spotify%3aspotify%253atrack%253a0Vh1sTeybmGy8Kxl2vw0Ye%3fsid%3d9%26flags%3d8224%26sn%3d1", "title": "Time Is Running Out - (Live) Explicit Version", "creator": "Papa Roach", "tags": "1"]

        let track = QueueTrackFactory(room: firstRoom().ip, queueItem: 1, data: data).create()
        XCTAssertEqual(track!.providerId, 9)
        XCTAssertEqual(track!.flags, 8224)
        XCTAssertEqual(track!.sn, 1)
        XCTAssertEqual(track!.queueItem, 1)
        XCTAssertEqual(track!.duration, 236)
        XCTAssertEqual(track!.uri, "x-sonos-spotify:spotify%3atrack%3a0Vh1sTeybmGy8Kxl2vw0Ye?sid=9&flags=8224&sn=1")
        XCTAssertEqual(track!.imageUri.absoluteString, "http://192.168.3.14:1400/getaa?s=1&u=x-sonos-spotify:spotify%3atrack%3a0Vh1sTeybmGy8Kxl2vw0Ye?sid=9&flags=8224&sn=1")
        XCTAssertEqual(track!.title, "Time Is Running Out - (Live) Explicit Version")
        XCTAssertEqual(track!.artist, "Papa Roach")
        XCTAssertEqual(track!.album, "Time For Annihilation: On the Record & On the Road")
        XCTAssertNil(track!.information)
        XCTAssertEqual(track!.description, [TrackDescription.title: "Time Is Running Out - (Live) Explicit Version", TrackDescription.artist: "Papa Roach", TrackDescription.album: "Time For Annihilation: On the Record & On the Road"])
    }
    
    func testItCanCreateSpotifyTrackWithoutData() {
        let data = ["res": "x-sonos-spotify:spotify%3atrack%3a0Vh1sTeybmGy8Kxl2vw0Ye?sid=9&flags=8224&sn=1"]
        
        let result = QueueTrackFactory(room: firstRoom().ip, queueItem: 1, data: data).create()
        XCTAssertNil(result)
    }
    
    func testItCantCreateTrackWithoutData() {
        let result = QueueTrackFactory(room: firstRoom().ip, queueItem: 1, data: [:]).create()
        XCTAssertNil(result)
    }
    
}
