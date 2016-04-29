## Directory graph generation

### What is this?
This is a simple shell script that runs `find .` on the current directory and coverts the supplied paths to [Dot language](https://en.wikipedia.org/wiki/DOT_%28graph_description_language%29). The conversion is done as a series of replacements done by the `sed` command.<br> 
Running the command on the this repository produced :
![Alt text](sample.jpg?raw=true "Looks nice, doesn't it?")

**The script will only work on Mac OSX and other FreeBSD distributions because of the `sed -E` parameter. To make it work on other unix distributions, simply change the `sed -E` to `sed -r`.**

### Installing and running the command
You will need to install [graphviz](http://www.graphviz.org) to see the graph. Once you have that installed, place the script in the directory whose graph you want. Now run the command by typing the following the directory you want to :
```
  sh dir_tree.sh [filename].dot
``` 
You can name the file anything, but the file extension needs to be `.dot`. Once the command has stopped running, open the file using `graphviz`. <br>

If you get you get an error saying that you don't have execution permissions, run this command :
```bash
  chmod +x dir_tree.sh
```
The command grants execution permissions to all the users. Once you have the access, try running the command again.<br>

*Sanity note : Please don't run this command on a root directory with lots of children directory. The command will terminate, but `graphviz` might not be able to process the generated structure.*

### How does it work?
Let's walk through the `sed` replacements in the script. 
+ `sed -E 's/([^/]+\/)*([^/]+\/[^/]+)$/\2/'` : For the match part of the clause, we have the regex `([^/]+\/)*([^/]+\/[^/]+)$` which tries to match all paths of the form `<pathN>*/<path1>/<path2>` and converts it to `<path1>/<path2>`. This is done to remove redundant edges in the dot language, since `find .` gives us the complete path name everytime. 
+ `sed -E 's/([^/]*)(\/)?/"\1"\2/g'` : The match clause matches `path1/path2` and converts it to `"path1"/"path2"` for the dot language. This is done because it is always better to have quoted labels for dot structures.
+ `sed 's|/| -> |g'` : A very simple command to convert all the `/` to ` -> ` to get the desired structure in dot language.
+ `sed 's/$/;/'` : Another simple command to add a `;` to the end of each line.

####Notes
+ The `set -eu` at the start of the script makes the script fail at the first error. You might be wondering why we need to explicitly say. That is because bash was made by aliens.
+ One my notice that the dot structure I am using is a `strict diagraph` which can forces removal of redundant edges and wonder why I have the first `sed` replacement. What can I say, I was on a roll and wanted to do everything by hand, so I added the replacement.

###Additional thoughts
Maybe add a small script to filter out unwanted directory and random hidden files.
