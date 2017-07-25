# downloadRandImage 

### The minimal abstract task is:
To make stand-alone GUI-less application to download a random wallpaper in the same directory where it runs. The target-website is `alpha.wallhaven.cc`. It requires us to use *SSL* and to have a valid *User-Agent* value.

### Additional features:
  - *multy-download* - an opportunity to download `N` images per one run if binary is named like `[FileName][N].[extName]`, where `N` - is some number
  - *parallel processing* while downloading multiple images
  
### Progress:

| Language| basics | multy-download | parallel processing  |
|---------|--------|----------------|----------------------|
| c#      | •      | •              | •                    |
| d       | •      | •              | •                    |
| nim     | •      | •              |                      |
| java    | •      | •              |                      |
| rust    | •      |                |                      |
| clojure | •      |                |                      |
