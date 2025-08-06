# Rotten Potatoes: Movie Review Application

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [Build Instructions](#Build-Instructions)

## Overview
Rotten Potatoes, incorporates various UI based elements in order to display multiple options for the user to browse through either popular or newly released movies.

<div>
    <a href="https://www.loom.com/share/0bef3fcc928542c6a5d97b3b953eab69">
    </a>
    <a href="https://www.loom.com/share/0bef3fcc928542c6a5d97b3b953eab69">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/0bef3fcc928542c6a5d97b3b953eab69-c8566bbcac551bb9-full-play.gif">
    </a>
  </div>

### Description
Rotten Potatoes, gives users the chance to document and log their film watching journey. Where users are immediately presented with a list of newly released fims. Users can add movies to their watchlist and/or even write a review to be shared with the other users of the Rotten Potatoes Application. Users can keep track of their watchlists and reviews, with the capablity to view at any time.

### App Evaluation
- **Category:**
    - Film, Entertainment, Documentation
- **Mobile:**
    - mobile-friendly application, allows users to stay up to date on latest movie releases
- **Story:**
    - Single source to reflect on preiviously viewed movies
- **Market:**
    - indirect consumers, market towards film industry, could possibly list featured movies ahead of popular movies, or include sponsor-based movies in recommendations.
- **Habit:**
    - quick review, and ability to stay up to date on newest releases
- **Scope:**
    - can grow, api endpoints for TMDB is quite large, so it's possible to grow beyond the MVP.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* A user can open the application, and be presented a list of Newly Released films in Theaters
* A user can select a newly release film, in order to view their details of a movie and `add to watchlist` after which the user can access their `watchlist` by pressing the `watchlist` tab.
* A user can view the details of a movie and `write a review`, where they can add title, description and rating of the movie.
* A user can access previously written reviews by selecting the `reviews` tab, 

**Optional Nice-to-have Stories**

* user is presented a Carousel of Popular Movies presented in Carousel fashion on the home page of the application
* for each detail, a recommendations Carousel is presented before the Reviews section of the movie in which users can select and view other movie's details
* 

### 2. Screen Archetypes

- [x] Stream of New Releases
    * A user can open the application, and be presented a list of Newly Released films in Theaters
    * ...
- [x] Details of a Movie
    * A user can select a newly release film, in order to view their details of a movie and `add to watchlist` or `write a review` for the movie
- [ ] Create a Movie Review
    * A user can write a review of a movie, provided a `title`, `description` and `rating` of the movie
- [ ] Stream of User's watchlist
    * User can select the `watchlist` tab and be presented with all movies saved in the user's `watchlist`
- [ ] Stream of User's reviews
    * User can select the `reviews` tab and be presented with all reviews the author has made.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* New Releases (Home Page)
* Watchlist
* Reviews

**Flow Navigation** (Screen to Screen)

- [ ] New Releases
* Movie Details
- [ ] Movie Details
* add to watchlist
* write a Review
- [ ] Write a Review
* Movie Details
- [ ] User selects Reviews Tab
* present with Stream of Users Reviews
- [ ] User selects Watchlist Tab
* present with Stream of Movies in Watchlist


## Wireframes

<img src="https://i.imgur.com/h1KBmDe.png" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/qAX7JkB.png" width=600>
</br>

Figma Wireframe: <a href="https://www.figma.com/design/YuGDXkLuxBonVvkBIoi32k/iOS-Capstone?node-id=0-1&t=NGrs05TayeSCUMNR-1">Link to Figma</a>

### [BONUS] Interactive Prototype

## Schema 
<img src="https://i.imgur.com/i6rksLm.png" width=600>

Link to draw-db.app: [Draw-db](https://www.drawdb.app/editor?shareId=878b0c32a0091f01ad369bc6a2843586)
### Models
|Model|properties|
|---|---|
|Movie|`title` `overview` `backdropPath` `posterPath` `avgRating`|
|User|`name` `password` `reviews: Review[]` `watchlist: Movie[]`|
|Review|`title` `description` `rating`


### Networking

- Home page
    - TMDB API: `movie/now_playing`
    - TMDB API: `movie/upcoming`
- Movie Details
    - TMDB API: `/movie/{movie_id}/recommendations`


---
### Build Instructions
I wanted to preserve my API Key and API Read Access Token from being exposed on the internet so I have it placed in a `Config.xcconfig` file that is not shared directly in the repository, If needed I can share my API Key and API Read Access Token.

#### Steps to get the application running
- create a `Config.xcconfig` file
- add lines below:
```shell=
API_KEY=<API_KEY_GOES_HERE>
API_READ_ACCESS_TOKEN=<API_READ_ACCESS_TOKEN_GOES_HERE>
```
- Go to the Info tab of your project settings.
- Expand the Configurations section (typically Debug and Release).
- add `Config.xcconfig` to the Build Config
- also add these lines to `info.plist` in a text editor
```xml=
<key>API_READ_ACCESS_TOKEN</key>
<string>$(API_READ_ACCESS_TOKEN)</string>
<key>API_KEY</key>
<string>$(API_KEY)</string>
```
- after which the api key and read access token should be available and app should compile smoothly.
