module g_action;

class Action {
    
    //std.file:
    
    // getcwd
    
    // mkdir
    // rmdir
    // copy
    // rename (Rename file from to to. If the target file exists, it is overwritten.)
    /*
unCp(file0, file1): rm(file1) if and only if sha1(file0) == sha1(file1)
mkJunk(file0): creates file of random size with random data inside

rmDir(dir0) ⇔ mkDir(dir0)                   
mkDir(dir0) ⇔ rmDir(dir0)                 // only works if dir0 is empty
copy(file0, file1) ⇔ drain(file0, file1)  
drain(file0, file1) ⇔ copy(file0, file1) // should remember all the clones (does it have any sense to use?)
mv(file0, file1) ⇔ mv(file1, file0)
mkJunk(file0) ⇔ rm(file0)

complex dir hierarchy?
many different strategies of spoiling
*/
}