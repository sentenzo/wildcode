# replicaHunter 

###The minimal abstract task is:
To make stand-alone console-app for seeking file-duplicates in directories. As the first approach it is acceptable to check only filenames for duplicate.

###How should it work:

    > ./replicaHunter ~/music ~/other_music/_m
    3
       ~/music/track01.mp3
       ~/other_music/_m/track01.mp3
       ~/other_music/_m/a/track01.mp3
    2
       ~/music/track00.mp3 2
       ~/other_music/_m/track00.mp3 2

###Additional features:
  - use hash-sums, not filenames
  - sort results by frequency
  - show progress bar in console (something like this `00:00:39 [=====>................] 26%`)
  
###Progress:

| Language| basics | hash-sums | sorted results  | progress bar |
|---------|--------|-----------|-----------------|--------------|
| c#      | •      | •         | •               |              |
