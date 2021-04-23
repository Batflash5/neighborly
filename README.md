# Neighbourly

A Flutter application which lets users meet the neighbours and get involved in social activities and 
events and Find out about local issues and influence those around them.
For the Backend code (API which connects app to firebase) refer to the repo https://github.com/Batflash5/Neighbourly

## Description

First and foremost users must sign with their email address and login using the email address after they verify their id. 

Firebase is used for storing the user’s data, authenticating and verifying them. 

After they sign-in, users will be redirected to the Home screen where we retrieve the location of the user 
and use it for displaying their location and as well as location of the people in the neighbourhood who use Neighbourly. 

Users can switch to the Feed screen to view the issues/events posted by the users in the neighbourhood. 

To add an issue/event users can switch to the File an Issue screen and provide the necessary details and file the issue/event. 

Also users can update, delete the posts they posted in the Myposts Screen. When an issue is solved / an event is over, users who posted the issue/event can mark the status as resolved. 

For retrieving and updating the data, we make a call to an API deployed using Heroku which updates / retrieves the data from Firebase .


## Authors

Hari Prasath M   https://github.com/Batflash5
Rahul S          https://github.com/rahulsavage12


