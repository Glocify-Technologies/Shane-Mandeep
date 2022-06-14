//
//  PaymentAPO.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 31/05/22.
//

import Foundation
open class PaymentAPI {
    
    /**
     StripeConnect
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   
     */
    open class func stripeConnect(accept: String, completion: @escaping ((_ data: SuccessResponse?,_ error: Error?) -> Void)) {
        stripeConnectWithRequestBuilder(accept: accept).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     StripeConnect
     - POST /connect
     -
     - API Key:
       - type: apiKey x-access-token
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   

     - returns: RequestBuilder<PetProfileAddNewPetProfileResponse>
     */
    open class func stripeConnectWithRequestBuilder(accept: String) -> RequestBuilder<SuccessResponse> {
        let path = "/connect"
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [:]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SuccessResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    
    /**
     StripeConnect
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   
     */
    open class func addNewPaymentMethod(accept: String,paymentMethodId:String,isDefaultMethod:String, completion: @escaping ((_ data: SaveCardSuccessResponse?,_ error: Error?) -> Void)) {
        addNewPaymentMethodWithRequestBuilder(accept: accept,paymentMethodId: paymentMethodId,isDefaultMethod: isDefaultMethod).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Add New Card

     - POST /payment/methods/store
     -
     - API Key:
       - type: apiKey x-access-token
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   

     - returns: RequestBuilder<PetProfileAddNewPetProfileResponse>
     */
    open class func addNewPaymentMethodWithRequestBuilder(accept: String,paymentMethodId:String,isDefaultMethod:String) -> RequestBuilder<SaveCardSuccessResponse> {
        let path = "/payment/methods/store"
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [
            "payment_method_id":paymentMethodId,
            "is_default":isDefaultMethod]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SaveCardSuccessResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    
    
    
    /**
     AddCardOnStripe
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   
     */
    open class func addCardOnStripe(accept: String,tokenID:String,custmerId:String, completion: @escaping ((_ data: StripeSuccessResponse?,_ error: Error?) -> Void)) {
        addCardOnStripeWithRequestBuilder(accept: accept,tokenID:tokenID,custmerId:custmerId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Add New Card

     - POST /payment/methods/store
     -
     - API Key:
       - type: apiKey x-access-token
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   

     - returns: RequestBuilder<PetProfileAddNewPetProfileResponse>
     */
    open class func addCardOnStripeWithRequestBuilder(accept: String,tokenID:String,custmerId:String) -> RequestBuilder<StripeSuccessResponse> {
        let URLString = "https://api.stripe.com/v1/customers/\(custmerId)/sources"
        let formParams: [String:Any?] = [
            "source":tokenID]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        let secretKey = "sk_test_51L5MuZFmf8FdDZk7wtdiDCGNG9BvzWLkL6TL5CoJA5biULCSS7CGaHKofem5w6oeYSS2UVd2IIOTYJ7IFhazlmoQ00SvjD2F9A"
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept,
            "Authorization":"Bearer \(secretKey)"
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<StripeSuccessResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    
    
    /**
     Get Payment Methods
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPaymentMethods(accept: String, completion: @escaping ((_ data: SaveCardSuccessResponse?,_ error: Error?) -> Void)) {
        getPaymentMethodsWithRequestBuilder(accept: accept).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get Payment Methods
     - GET /payment/methods
     -
     - API Key:
       - type: apiKey x-access-token
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;

     - returns: RequestBuilder<TranierGetTranierProfileResponse>
     */
    open class func getPaymentMethodsWithRequestBuilder(accept: String) -> RequestBuilder<SaveCardSuccessResponse> {
        let path = "/payment/methods"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SaveCardSuccessResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    
    /**
     Get Payment Methods
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getTrainerPaymentMethods(accept: String, completion: @escaping ((_ data: SuccessResponse?,_ error: Error?) -> Void)) {
        getTrainerMethodsWithRequestBuilder(accept: accept).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get Strip Account
     - GET /connect/methods
     -
     - API Key:
       - type: apiKey x-access-token
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;

     - returns: RequestBuilder<TranierGetTranierProfileResponse>
     */
    open class func getTrainerMethodsWithRequestBuilder(accept: String) -> RequestBuilder<SuccessResponse> {
        let path = "/connect/methods"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SuccessResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    
    /**
     Delete Strip Account
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   
     */
    open class func deleteTrainerPaymentMethod(accept: String,paymentMethodId:String, completion: @escaping ((_ data: SuccessResponse?,_ error: Error?) -> Void)) {
        deleteTrainerPaymentMethodWithRequestBuilder(accept: accept,paymentMethodId: paymentMethodId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Add New Card

     - POST //connect/delete
     -
     - API Key:
       - type: apiKey x-access-token
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   

     - returns: RequestBuilder<PetProfileAddNewPetProfileResponse>
     */
    open class func deleteTrainerPaymentMethodWithRequestBuilder(accept: String,paymentMethodId:String) -> RequestBuilder<SuccessResponse> {
        let path = "/connect/delete"
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [:]
//            "payment_method_id":paymentMethodId,
//            ]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SuccessResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    
    /**
     Stripe payment
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   
     */
    open class func PayNow(accept: String,paymentMethodId:String,bookingId:String,amount:String, completion: @escaping ((_ data: PaymentSuccessResponse?,_ error: Error?) -> Void)) {
        PayNowWithRequestBuilder(accept: accept,paymentMethodId: paymentMethodId,bookingId: bookingId,amount: amount).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Add New Card

     - POST /payment/methods/store
     -
     - API Key:
       - type: apiKey x-access-token
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key
       - name: apiKey
     - examples: [{contentType=application/json, example={"empty": false}}]
     
     - parameter accept: (header) Set to &#x60;application/json&#x60;
   

     - returns: RequestBuilder<PetProfileAddNewPetProfileResponse>
     */
    open class func PayNowWithRequestBuilder(accept: String,paymentMethodId:String,bookingId:String,amount:String) -> RequestBuilder<PaymentSuccessResponse> {
        let path = "/payment"
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [
            "amount":amount,
            "booking_id":bookingId,
            "payment_method_id":paymentMethodId]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
            "Accept": accept
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<PaymentSuccessResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
}
