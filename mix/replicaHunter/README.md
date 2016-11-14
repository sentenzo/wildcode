# replicaHunter 

###The minimal abstract task is:
To make stand-alone console-app for seeking file-duplicates in directories.

###How should it work

    > replicaHunter ~/music ~/other_music/_m
    9326
       ~/music/track01.mp3
       ~/other_music/_m/track01.mp3
       ~/other_music/_m/a/track01.mp3
    1234
       ~/music/track00.mp3 2
       ~/other_music/_m/track00.mp3 2

       