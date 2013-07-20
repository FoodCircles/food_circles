1# FoodCircles API Docs

## Sessions

#### Sign in

`POST /api/sessions/sign_in`

Params: `user_email`, `user_password`

Example responses:

Bad login:

	{
    	"description": "Wrong password.", 
    	"error": true
	}
	
Successful login:

	{
    	"auth_token": "some_auth_token", 
    	"error": false
	}

`auth_token` is the token you have to use in order to authenticate for the requests. It'll go as GET param, such as `http://foodcircles.net/api/timeline?auth_token=<token>`.

#### Sign up

`POST /api/sessions/sign_up`

Params: `user_email`, `user_password`

Example responses:

Error signing up:

	{
    	"description": "Error saving user.", 
    	"error": true, 
    	"errors": {
        	"email": [
            	"has already been taken"
        	]
    	}
	}

The `errors` key will contain the key with the error and the actual error.

Successful sign up:

	{
    	"description": "User saved.", 
    	"error": false,
    	"auth_token":"some_auth_token"
	}

#### Update user information

`PUT /api/sessions/update`

Params: Any of the user model (currently `email`, `password`, `name` and `phone`, but this can change)

Example responses:

Bad auth token error: 

	{
    	"error": "Invalid authentication token."
	}
	
Error while saving due to a validation failure:

	{
    	"description": "Error saving user.", 
    	"error": true, 
    	"errors": {
        "email": [
            	"has already been taken"
        	]
    	}
	}
	
Successful update:

	{
    	"description": "User saved.", 
    	"error": false
	}

## News

**This needs to be implemented completely since there's nothing related to news in the app.**

## Venues ans Charities

#### Venues

`GET /api/venues/:lat/:lon`

Params: `lat` and `lon` which specifies the current latitude and longitude.

Example responses:

	{
    	"content": [
        	{
	            "address": "Ionia Avenue SW", 
	            "city": "Grand Rapids", 
	            "description": "A local pick especially for breakfast, EtC offers a deep,
	        	affordable, and tasty menu for all times of day.", 
	            "distance": "", 
	            "end": "Later Tonight", 
	            "id": 10, 
	  	        "lat": 47.604828, 
	            "lon": -122.330779, 
	            "main_image": "/media/BAhbBlsHOgZmSSIQdmVudWVzLzEyXzEGOgZFVA", 
	            "name": "Eastown Cafe", 
	            "neighborhood": "Eastown", 
	            "offers": [], 
	            "open_times": [], 
	            "phone": null, 
	            "rating": null, 
            	"reviews": [], 
            	"start": "Later Tonight", 
            	"state": "", 
            	"tags": [], 
            	"timeline_image": "", 
            	"web": "url: http://www.facebook.com/pages/The-Eastown-Cafe/113252522028522, 				phone_num: 616-233-0797", 
            	"zip": "49503"
        	}
    	], 
    	"error": false
	}

The `content` array will be empty if no venues are found.

#### Charities 

`GET /api/charities`

Params: none

Example response:

	{
    	"content": [
        	{
            	"description": "Pablo's charity\r\n", 
            	"id": 1, 
            	"name": "Pablo's Charity"
        	}
    	], 
    	"error": false
	}

The `content` array will be empty if no charities are found.

## Timeline

#### Show timeline

`GET /api/timeline`

Params: `auth_token` with a valid token in order to show the user's timeline.

Example response:

	{
	    "content": {
	        "available_vouchers": 0, 
	        "payments": [
	            {
	                "amount": 1.5, 
	                "id": 2, 
	                "offer": [
	                    {
	                        "available": 10, 
	                        "details": "With purchase of at least 2 slices of pizza per person", 
	                        "id": 1, 
	                        "name": "2 free desserts", 
	                        "price": 3.5, 
	                        "total": 10, 
	                        "venue": [
	                            {
	                                "description": "Georgio’s Pizza stands out from other pizza parlors with its affordability, ingredient ingenuity (58 flavors!), and its cool interiors.", 
	                                "id": 1, 
	                                "name": "Georgio's Gourmet Pizza"
	                            }
	                        ]
	                    }
	                ], 
	                "user_id": 9
	            }, 
	            {
	                "amount": 1.5, 
	                "id": 1, 
	                "offer": [
	                    {
	                        "available": 10, 
	                        "details": null, 
	                        "id": 8, 
	                        "name": "1 free appetizer", 
	                        "price": 1.5, 
	                        "total": 10, 
	                        "venue": [
	                            {
	                                "description": "Queen's has different music themes &amp; drink specials each night to compliment traditional English-style and Indian-style food.", 
	                                "id": 3, 
	                                "name": "Queen's Pub"
	                            }
	                        ]
	                    }
	                ], 
	                "user_id": 9
	            }
	        ], 
	        "total_vouchers": 0, 
	        "weekly_total": 0
	    }, 
	    "error": false
	}
	
#### Payments

**The payments API is to be integrated by the mobile app developer.**

#### Voucher using

**There's no way to mark a voucher as used in the codebase currently.**
