//
//  MusicServiceTests.swift
//  RxSonosLibTests
//
//  Created by Stefan Renne on 27/03/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import XCTest
@testable import RxSonosLib

class MusicServiceTests: XCTestCase {
    
    func testItCanParseUnkownMusicServices() throws {
        XCTAssertNil(try MusicService.map(url: ""))
        XCTAssertNil(try MusicService.map(url: "random"))
    }
    
    func testItCanParseSpotifyMusicServices() throws {
        XCTAssertEqual(try MusicService.map(url: "x-sonos-spotify:spotify%3atrack%3a5HR4CYT5nPpFy8m9wJQgrr?sid=9&flags=0&sn=6"), MusicService.musicProvider(sid: 9, flags: 0, sn: 6))
    }
    
    func testItCanParseTuneInMusicServices() throws {
        XCTAssertEqual(try MusicService.map(url: "x-sonosapi-stream:s6712?sid=254&flags=32"), MusicService.musicProvider(sid: 254, flags: 32, sn: nil))
    }
    
    func testItCanParseTVMusicServices() throws {
        XCTAssertEqual(try MusicService.map(url: "x-sonos-htastream:RINCON_000E58B4AE9601400:spdif"), MusicService.tv)
    }
 
}
