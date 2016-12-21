# UNMAINTAINED

Since we stopped using puppet for our infrastructure, we are not going to 
maintain this solution anymore.

# etherpad-lite

`puppet-etherpad` installs etherpad lite and starts the nodejs
server. Afterwards you may define some additional services like
a reverse proxy for serving etherpad-lite via HTTPS.

## Usage

```
  class { 'etherpad': }
```

## Contribute

Want to help - send a pull request.
