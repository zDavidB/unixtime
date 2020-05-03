# UnixTime

Script to generate the Unixtime, typically while in a term session on a Mac
`date +%s` will do the job just as well for the current date and time, but
so you don't have to enter all the formatting to get a specific date and time
this script, or an alias to this script does the should with fewer keystrokes.


Usage `unixtime.sh [$1] [[$2]]`

Takes zero, or one or two  inputs to return the date and time, with the equivalent Unix time.

\$1 = the date field, either blank for current date, a specific date yyyy-mm-dd or a +/- offset in days

\$2 = the time field, either blank for the current time, a specific time HH:mi:ss or +/- offset in hours

Examples: 
* `unixtime.sh` : uses current date and time
* `unixtime.sh -n`     : uses the date n days ago and current time
* `unixtime.sh -0 -n`  : uses the current date and time n hours ago
* `unixtime.sh 2019-01-21 06:30:00`  : uses the specific date and time

* or combinations of specific date/time and +/- offset


Output 
		    
`21/01/2019 06:30:00 1548052200`

Other Options

<pre>
-h    Prints the message and exits
</pre>

### Shellcheck
Script is validated with shellcheck.

### Testing

Script as an associated BATS test script, once the framework is installed with Homebrew,
execute `unixtime.bats`

expected output
<pre>
 ✓ Script Info and Init
 ✓ Call to script with no args, completes ok
 ✓ Call to script with no args, returns current date
 ✓ Call to script with specific date, returns that date
 ✓ Call to script with specific time, returns that time and current date
 ✓ Call to script with specific date and time, returns that date and time

6 tests, 0 failures
</pre>

# BATS testing framework

Ref:-
* https://github.com/ztombol/bats-docs
* https://github.com/sstephenson/bats
* https://github.com/ztombol/bats-support
* https://github.com/ztombol/bats-assert

### Homebrew

OS X users can use [Homebrew](http://brew.sh/) to install libraries
system-wide (see note below for alternatives).

The forumlae are in a tap for various shell utilities by
[@kaos](https://github.com/kaos), so enable the tap
[kaos/shell](https://github.com/kaos/homebrew-shell) first.

```sh
$ brew tap kaos/shell
```

Then install the desired libraries.

```sh
$ brew install bats-assert
$ brew install bats-file
```

*__Note:__ The required dependencies, `bats-support` as well as `bats`
from the core tap will be installed automatically for you, with any of
the two previous commands.*

*__Note:__ Homebrew installs packages in a system-wide `/usr/local`
prefix by default. This is encouraged praxis when using `brew`, but
optional. See
[Alternative Installs](https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Installation.md#alternative-installs)
from the Homebrew documentation for details.*
