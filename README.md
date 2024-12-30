Micro is an Urbit app that allows you to create and publish toy web apps within a TikTok-like interface. ([Video here.](https://x.com/hanfel_dovned/status/1716515932099739731))

In addition to a bunch of built-in apps, Micro contains two major agents: `micro.hoon` and `creator.hoon`. 

`micro.hoon` is responsible for listening to the global publisher ship for new apps that have been published, organizing those apps into a feed, and serving them to the frontend.

`creator.hoon` serves a frontend that allows you to create apps, and tracks the state of those apps.

Each app you build with `creator` is hosted on your ship and contains a `(map ship (map key=@t value=@t))`. `creator` allows other Urbit users to eauth into apps on your ship, and provides an endpoint for your app to allow those users to post data to the map under their Urbit ID. Getting clever with the data you store in this map can allow you to build anything; use dates for keys and then sort through all data across all users to create a feed of content. (A talented web programmer could of course abuse this endpoint to store arbitrary key-value pairs under their own Urbit ID for any given app, but for the types of toy apps you'll be publishing with this, that's fine.) 

Install Micro from ~ridlyd via Urbit software distribution or via the desk in this repo.
