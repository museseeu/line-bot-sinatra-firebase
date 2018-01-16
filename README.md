# Line-bot-sinatra-firebase 

LINE bot of the API for sinatra/firebase.



<img src="https://github.com/museseeu/line-bot-sinatra-firebase/blob/master/Screenshot.png" width="400">

## Installation ##

execute:

```sh
$ bundle install
```

## Configuration ##

```ruby

# line bot env
ENV['LINE_CHANNEL_SECRET']
ENV['LINE_CHANNEL_TOKEN']

# firebase env
ENV['FIREBASE_DB_URL']
ENV['FIREBASE_AUTH_TOKEN']

```

## How to start ##

```sh
$ rackup -p 4567
```

Or 

```sh
$ ruby app.rb
```

easy for you.

## Requirements

https://github.com/oscardelben/firebase-ruby

https://github.com/line/line-bot-sdk-ruby

See the official API reference documentation for more information.
https://devdocs.line.me/


