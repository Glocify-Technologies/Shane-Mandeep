//
// PetProfileAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class PetProfileAPI {
    /**
     delete pet profile
     
     - parameter accept: (header) Set to &#x60;application/json&#x60; 
     - parameter _id: (form) profile id (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func petProfileDeleteDeletePetProfile(accept: String, _id: String? = nil, completion: @escaping ((_ data: PetProfileDeletePetProfileResponse?,_ error: Error?) -> Void)) {
        petProfileDeleteDeletePetProfileWithRequestBuilder(accept: accept, _id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     delete pet profile
     - DELETE /pet_profile/delete
     - 
     - API Key:
       - type: apiKey x-access-token 
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key 
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60; 
     - parameter _id: (form) profile id (optional)

     - returns: RequestBuilder<PetProfileDeletePetProfileResponse> 
     */
    open class func petProfileDeleteDeletePetProfileWithRequestBuilder(accept: String, _id: String? = nil) -> RequestBuilder<PetProfileDeletePetProfileResponse> {
        let path = "/pet_profile/delete"
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [
            "id": _id
        ]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<PetProfileDeletePetProfileResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     Get All Pet Profile
     
     - parameter accept: (header) Set to &#x60;application/json&#x60; 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func petProfileGetGetAllPetProfile(accept: String, completion: @escaping ((_ data: PetProfileGetAllPetProfileResponse?,_ error: Error?) -> Void)) {
        petProfileGetGetAllPetProfileWithRequestBuilder(accept: accept).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get All Pet Profile
     - GET /pet_profile/all
     - 
     - API Key:
       - type: apiKey x-access-token 
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key 
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60; 

     - returns: RequestBuilder<PetProfileGetAllPetProfileResponse> 
     */
    open class func petProfileGetGetAllPetProfileWithRequestBuilder(accept: String) -> RequestBuilder<PetProfileGetAllPetProfileResponse> {
        let path = "/pet_profile/all"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<PetProfileGetAllPetProfileResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     Add new pet profile
     
     - parameter accept: (header) Set to &#x60;application/json&#x60; 
     - parameter profileName: (form) profile name (optional)
     - parameter petName: (form) pet name (optional)
     - parameter breed: (form) breed (optional)
     - parameter age: (form) age (optional)
     - parameter gender: (form) gender (optional)
     - parameter treatment: (form) Array of treatment ex:- treatment 1, treatment 2 (optional)
     - parameter _description: (form) description of pet (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func petProfilePostAddNewPetProfile(accept: String, profileName: String? = nil, petName: String? = nil, breed: String? = nil, age: String? = nil, gender: String? = nil, treatment: String? = nil, _description: String? = nil, completion: @escaping ((_ data: PetProfileAddNewPetProfileResponse?,_ error: Error?) -> Void)) {
        petProfilePostAddNewPetProfileWithRequestBuilder(accept: accept, profileName: profileName, petName: petName, breed: breed, age: age, gender: gender, treatment: treatment, _description: _description).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Add new pet profile
     - POST /pet_profile
     - 
     - API Key:
       - type: apiKey x-access-token 
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key 
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60; 
     - parameter profileName: (form) profile name (optional)
     - parameter petName: (form) pet name (optional)
     - parameter breed: (form) breed (optional)
     - parameter age: (form) age (optional)
     - parameter gender: (form) gender (optional)
     - parameter treatment: (form) Array of treatment ex:- treatment 1, treatment 2 (optional)
     - parameter _description: (form) description of pet (optional)

     - returns: RequestBuilder<PetProfileAddNewPetProfileResponse> 
     */
    open class func petProfilePostAddNewPetProfileWithRequestBuilder(accept: String, profileName: String? = nil, petName: String? = nil, breed: String? = nil, age: String? = nil, gender: String? = nil, treatment: String? = nil, _description: String? = nil) -> RequestBuilder<PetProfileAddNewPetProfileResponse> {
        let path = "/pet_profile"
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [
            "profile_name": profileName,
            "pet_name": petName,
            "breed": breed,
            "age": age,
            "gender": gender,
            "treatment": treatment,
            "description": _description
        ]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<PetProfileAddNewPetProfileResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     update pet profile
     
     - parameter accept: (header) Set to &#x60;application/json&#x60; 
     - parameter _id: (form) profile id (optional)
     - parameter profileName: (form) profile name (optional)
     - parameter petName: (form) pet name (optional)
     - parameter breed: (form) breed (optional)
     - parameter age: (form) age (optional)
     - parameter gender: (form) gender (optional)
     - parameter treatment: (form) Array of treatment ex:- treatment 1, treatment 2 (optional)
     - parameter _description: (form) description of pet (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func petProfilePostUpdatePetProfile(accept: String, _id: String? = nil, profileName: String? = nil, petName: String? = nil, breed: String? = nil, age: String? = nil, gender: String? = nil, treatment: String? = nil, _description: String? = nil, completion: @escaping ((_ data: PetProfileUpdatePetProfileResponse?,_ error: Error?) -> Void)) {
        petProfilePostUpdatePetProfileWithRequestBuilder(accept: accept, _id: _id, profileName: profileName, petName: petName, breed: breed, age: age, gender: gender, treatment: treatment, _description: _description).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     update pet profile
     - POST /pet_profile/update
     - 
     - API Key:
       - type: apiKey x-access-token 
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key 
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60; 
     - parameter _id: (form) profile id (optional)
     - parameter profileName: (form) profile name (optional)
     - parameter petName: (form) pet name (optional)
     - parameter breed: (form) breed (optional)
     - parameter age: (form) age (optional)
     - parameter gender: (form) gender (optional)
     - parameter treatment: (form) Array of treatment ex:- treatment 1, treatment 2 (optional)
     - parameter _description: (form) description of pet (optional)

     - returns: RequestBuilder<PetProfileUpdatePetProfileResponse> 
     */
    open class func petProfilePostUpdatePetProfileWithRequestBuilder(accept: String, _id: String? = nil, profileName: String? = nil, petName: String? = nil, breed: String? = nil, age: String? = nil, gender: String? = nil, treatment: String? = nil, _description: String? = nil) -> RequestBuilder<PetProfileUpdatePetProfileResponse> {
        let path = "/pet_profile/update"
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [
            "id": _id,
            "profile_name": profileName,
            "pet_name": petName,
            "breed": breed,
            "age": age,
            "gender": gender,
            "treatment": treatment,
            "description": _description
        ]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<PetProfileUpdatePetProfileResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

}
