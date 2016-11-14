# replicaHunter 

###The minimal abstract task is:
To make stand-alone console-app for seeking file-duplicates in directories. As the first approach it is acceptable to check only filenames for duplicate.

###How should it work:

    > ./replicaHunter ~/music ~/other_music/_m
    3 A02C
       ~/music/track01.mp3
       ~/other_music/_m/track01.mp3
       ~/other_music/_m/a/track01.mp3
    2 1234
       ~/music/track00.mp3 2
       ~/other_music/_m/track00.mp3 2

###Additional features:
  - use hash-sums, not filenames
