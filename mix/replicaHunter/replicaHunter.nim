import os
import tables
import future

var state = initOrderedTable[string, seq[string]]()

proc fileToMetric(file:string): string =
  let (_, name, ext) = splitFile(file)
  return name & ext

proc addToState(path:string): void =
  for file in walkDirRec(path):
    let metric = fileToMetric(file)
    discard state.hasKeyOrPut(metric, @[])
    state[metric].add(file)

proc main(): void =
  for path in commandLineParams():
    addToState(path)
  sort(state, (x,y) => cmp(y[1].len, x[1].len))
  for metric, fileList in state.pairs:
    if fileList.len > 1:
      echo fileList.len
      for file in fileList:
        echo "\t" & file
  
main()
