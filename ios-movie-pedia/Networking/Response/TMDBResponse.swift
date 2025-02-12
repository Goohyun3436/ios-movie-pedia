//
//  TMDBResponse.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation

struct TMDBResponse: Decodable {
    let page: Int
    let results: [Movie]
}

struct TMDBSearchResponse: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

struct TMDBCreditsResponse: Decodable {
    let cast: [Person]
}

struct TMDBImagesResponse: Decodable {
    let backdrops: [Image]
    let posters: [Image]
}

struct Movie: Decodable {
    static let genre = [
        12: GenreName(ko: "모험"),
        14: GenreName(ko: "판타지"),
        16: GenreName(ko: "애니메이션"),
        18: GenreName(ko: "드라마"),
        27: GenreName(ko: "공포"),
        28: GenreName(ko: "액션"),
        35: GenreName(ko: "코미디"),
        36: GenreName(ko: "역사"),
        37: GenreName(ko: "서부"),
        53: GenreName(ko: "스릴러"),
        80: GenreName(ko: "범죄"),
        99: GenreName(ko: "다큐멘터리"),
        878: GenreName(ko: "SF"),
        9648: GenreName(ko: "미스터리"),
        10402: GenreName(ko: "음악"),
        10749: GenreName(ko: "로맨스"),
        10751: GenreName(ko: "가족"),
        10752: GenreName(ko: "전쟁"),
        10770: GenreName(ko: "TV 영화")
    ]
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let release_date: String?
    let vote_average: Double?
    var is_like: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case backdrop_path
        case title
        case overview
        case poster_path
        case genre_ids
        case popularity
        case release_date
        case vote_average
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        overview = try container.decode(String.self, forKey: CodingKeys.overview)
        poster_path = try container.decode(String?.self, forKey: CodingKeys.poster_path)
        genre_ids = try container.decodeIfPresent([Int].self, forKey: CodingKeys.genre_ids)
        popularity = try container.decodeIfPresent(Double.self, forKey: CodingKeys.popularity)
        release_date = try container.decodeIfPresent(String.self, forKey: CodingKeys.release_date)
        vote_average = try container.decodeIfPresent(Double.self, forKey: CodingKeys.vote_average)
        is_like = UserStaticStorage.likes.contains(id)
    }
}

struct Person: Decodable {
    let name: String
    let original_name: String
    let profile_path: String?
}

struct Image: Decodable {
    let file_path: String?
}

struct GenreName {
    let ko: String
}

//MARK: - StatusCode
struct TMDBError: Decodable {
    let status_code: Int
}

enum TMDBStatusCode {
    case success
    case invalid_service
    case authentication_failed_permission
    case invalid_format
    case invalid_parameters
    case invalid_id
    case invalid_api_key
    case duplicate_entry
    case service_offline
    case suspended_api_key
    case internal_error
    case updated_success
    case deleted_success
    case authentication_failed
    case failed
    case device_denied
    case session_denied
    case validation_failed
    case invalid_accept_header
    case invalid_date_range
    case entry_not_found
    case invalid_page
    case invalid_date
    case timed_out
    case request_count_over
    case user_permission
    case too_many_response_object
    case invalid_timezone
    case confirm_parameter
    case invalid_username_or_password
    case account_disabled
    case email_not_verified
    case invalid_request_token
    case not_found
    case invalid_token
    case write_permission
    case session_not_found
    case edit_permission
    case resource_private
    case nothing_to_update
    case permission_by_user
    case method_not_supported
    case connection_failed
    case invalid_ID
    case user_suspended
    case api_is_undergoing
    case invalid_input
    case unowned
    
    init(_ statusCode: Int?) {
        switch statusCode {
        case 1:
            self = .success
        case 2:
            self = .invalid_service
        case 3:
            self = .authentication_failed_permission
        case 4:
            self = .invalid_format
        case 5:
            self = .invalid_parameters
        case 6:
            self = .invalid_id
        case 7:
            self = .invalid_api_key
        case 8:
            self = .duplicate_entry
        case 9:
            self = .service_offline
        case 10:
            self = .suspended_api_key
        case 11:
            self = .internal_error
        case 12:
            self = .updated_success
        case 13:
            self = .deleted_success
        case 14:
            self = .authentication_failed
        case 15:
            self = .failed
        case 16:
            self = .device_denied
        case 17:
            self = .session_denied
        case 18:
            self = .validation_failed
        case 19:
            self = .invalid_accept_header
        case 20:
            self = .invalid_date_range
        case 21:
            self = .entry_not_found
        case 22:
            self = .invalid_page
        case 23:
            self = .invalid_date
        case 24:
            self = .timed_out
        case 25:
            self = .request_count_over
        case 26:
            self = .user_permission
        case 27:
            self = .too_many_response_object
        case 28:
            self = .invalid_timezone
        case 29:
            self = .confirm_parameter
        case 30:
            self = .invalid_username_or_password
        case 31:
            self = .account_disabled
        case 32:
            self = .email_not_verified
        case 33:
            self = .invalid_request_token
        case 34:
            self = .not_found
        case 35:
            self = .invalid_token
        case 36:
            self = .write_permission
        case 37:
            self = .session_not_found
        case 38:
            self = .edit_permission
        case 39:
            self = .resource_private
        case 40:
            self = .nothing_to_update
        case 41:
            self = .permission_by_user
        case 42:
            self = .method_not_supported
        case 43:
            self = .connection_failed
        case 44:
            self = .invalid_ID
        case 45:
            self = .user_suspended
        case 46:
            self = .api_is_undergoing
        case 47:
            self = .invalid_input
        default:
            self = .unowned
        }
    }
    
    var statusCode: Int {
        switch self {
        case .success:
            return 200
        case .invalid_service:
            return 501
        case .authentication_failed_permission:
            return 401
        case .invalid_format:
            return 405
        case .invalid_parameters:
            return 422
        case .invalid_id:
            return 404
        case .invalid_api_key:
            return 401
        case .duplicate_entry:
            return 403
        case .service_offline:
            return 503
        case .suspended_api_key:
            return 401
        case .internal_error:
            return 500
        case .updated_success:
            return 201
        case .deleted_success:
            return 200
        case .authentication_failed:
            return 401
        case .failed:
            return 500
        case .device_denied:
            return 401
        case .session_denied:
            return 401
        case .validation_failed:
            return 400
        case .invalid_accept_header:
            return 406
        case .invalid_date_range:
            return 422
        case .entry_not_found:
            return 200
        case .invalid_page:
            return 400
        case .invalid_date:
            return 400
        case .timed_out:
            return 504
        case .request_count_over:
            return 429
        case .user_permission:
            return 400
        case .too_many_response_object:
            return 400
        case .invalid_timezone:
            return 400
        case .confirm_parameter:
            return 400
        case .invalid_username_or_password:
            return 401
        case .account_disabled:
            return 401
        case .email_not_verified:
            return 401
        case .invalid_request_token:
            return 401
        case .not_found:
            return 404
        case .invalid_token:
            return 401
        case .write_permission:
            return 401
        case .session_not_found:
            return 404
        case .edit_permission:
            return 401
        case .resource_private:
            return 401
        case .nothing_to_update:
            return 200
        case .permission_by_user:
            return 422
        case .method_not_supported:
            return 405
        case .connection_failed:
            return 502
        case .invalid_ID:
            return 500
        case .user_suspended:
            return 403
        case .api_is_undergoing:
            return 503
        case .invalid_input:
            return 400
        case .unowned:
            return 0
        }
    }
    
    var ko: String {
        switch self {
        case .success:
            return "성공"
        case .invalid_service:
            return "이 서비스는 존재하지 않습니다."
        case .authentication_failed_permission:
            return "서비스에 액세스할 수 있는 권한이 없습니다."
        case .invalid_format:
            return "잘못된 형식의 요청입니다."
        case .invalid_parameters:
            return "잘못된 요청 매개변수 입니다."
        case .invalid_id:
            return "필수 ID가 잘못되었거나 찾을 수 없습니다."
        case .invalid_api_key:
            return "유효하지 않은 API 키입니다."
        case .duplicate_entry:
            return "중복된 항목입니다."
        case .service_offline:
            return "TMDB 서비스가 현재 오프라인 상태입니다. 나중에 다시 시도하세요."
        case .suspended_api_key:
            return "TMDB 계정에 대한 엑세스가 정지되었습니다."
        case .internal_error:
            return "TMDB 서비스에 문제가 발생했습니다."
        case .updated_success:
            return "성공적으로 업데이트되었습니다."
        case .deleted_success:
            return "성공적으로 삭제되었습니다."
        case .authentication_failed:
            return "인증에 실패했습니다."
        case .failed:
            return "실패"
        case .device_denied:
            return "디바이스 장치가 거부되었습니다."
        case .session_denied:
            return "세션이 거부되었습니다."
        case .validation_failed:
            return "검증에 실패했습니다."
        case .invalid_accept_header:
            return "잘못된 헤더입니다."
        case .invalid_date_range:
            return "잘못된 날짜 범위 입니다. 14일을 넘을 수 없습니다."
        case .entry_not_found:
            return "편집하려는 항목을 찾을 수 없습니다."
        case .invalid_page:
            return "잘못된 페이지입니다. 1~500 사이의 정수여야 합니다."
        case .invalid_date:
            return "잘못된 날짜 형식입니다. YYYY-MM-DD의 형식을 사용하세요."
        case .timed_out:
            return "서버에 대한 요청 시간이 초과되었습니다. 다시 시도하세요."
        case .request_count_over:
            return "요청 수가 허용한도(40)를 초과했습니다."
        case .user_permission:
            return "사용자 이름과 비밀번호를 입력해야 합니다."
        case .too_many_response_object:
            return "응답 객체에 추가하려는 항목이 너무 많습니다. 원격 호출의 최대 개수는 20개 입니다."
        case .invalid_timezone:
            return "잘못된 시간대입니다."
        case .confirm_parameter:
            return "이 작업을 확인하려면 confirm=true 매개변수를 제공하세요."
        case .invalid_username_or_password:
            return "잘못된 사용자 이름 또는 비밀번호 입니다."
        case .account_disabled:
            return "귀하의 계정은 비활성화 상태입니다. TMDB에 문의하세요."
        case .email_not_verified:
            return "잘못된 이메일 입니다."
        case .invalid_request_token:
            return "요청 토큰이 만료되었거나 잘못되었습니다."
        case .not_found:
            return "요청하신 리소스를 찾을 수 없습니다."
        case .invalid_token:
            return "잘못된 토근입니다."
        case .write_permission:
            return "사용자로부터 이 토큰에 대한 쓰기 권한이 부여되지 않았습니다."
        case .session_not_found:
            return "요청하신 세션을 찾을 수 없습니다."
        case .edit_permission:
            return "이 리소스를 편집할 수 있는 권한이 없습니다."
        case .resource_private:
            return "이 자료는 비공개입니다."
        case .nothing_to_update:
            return "업데이트할 사항이 없습니다."
        case .permission_by_user:
            return "이 요청 토근은 사용자에 의해 승인되지 않았습니다."
        case .method_not_supported:
            return "이 리소스에는 해당 요청 방법이 지원되지 않습니다."
        case .connection_failed:
            return "TMDB 서버에 연결할 수 없습니다."
        case .invalid_ID:
            return "잘못된 ID 입니다."
        case .user_suspended:
            return "이 사용자는 정지되었습니다."
        case .api_is_undergoing:
            return "API가 유지 관리 중입니다. 나중에 다시 시도하세요."
        case .invalid_input:
            return "입력 내용이 올바르지 않습니다."
        case .unowned:
            return "Movie Pedia에 문제가 생겼습니다."
        }
    }
}
