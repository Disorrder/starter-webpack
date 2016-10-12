# Starter

## Before run
Without `sudo` on Windows
 - `sudo npm i -g bower` (install once)
 - `sudo npm i -g coffee-script` (install once)
 - `sudo npm i -g gulpjs/gulp#4.0` (install once)
 - `sudo npm i` (each time after pull)

## Dev run
`sudo gulp`
If browser didn't open automatically, console will show you address to open
 
## Production build
`sudo gulp build --production`

### fastest demo
`sudo npm run gulp`

### Dedicated run
`sudo gulp demo`

## Flags
 - `--production` - concat scripts except config. _TODO: Minify scripts and styles_
