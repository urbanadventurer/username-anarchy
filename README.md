Username Anarchy
======================================

* Version: 0.5 (October 2016)
* Author: urbanadventurer (Andrew Horton)
* Homepage: https://www.morningstarsecurity.com/research/username-anarchy
* Source: https://github.com/urbanadventurer/username-anarchy/

Description
------------
Tools for generating usernames when penetration testing. *Usernames are half the password brute force problem.*

This is useful for user account/password brute force guessing and username enumeration when usernames are based on the users' names. By attempting a few weak passwords across a large set of user accounts, user account lockout thresholds can be avoided.

Users' names can be identified through a variety of methods:
* Web scraping employee names from LinkedIn, Facebook, and other social networks.
* Extracting metadata from document types such as PDF, Word, Excel, etc. This can be performed with FOCA.

Common aliases, or self chosen usernames, from forums are also included.


Features
--------

* Plugin architecture for username formats
* Format string style username format definitions
* Substitutions. e.g. when only a first initial and lastname is known (LinkedIn lists users like this), it will attempt all possible first names
* Country databases of common first and last names from Familypedia and PublicProfiler
* Has the Facebook common first and lastnames lists


Extras
------

* Common forum usernames, ordered by popularity

Usage
-----
Username Anarchy is a command line tool.
```
	 ___ ____                                                        
	|   |    \ ______  ____ _______   ____  _____     __ __    ____  
	|   :    //  ___/_/    \\_  __ \ /    \ \__  \   /  :  \ _/    \
	'   .   / \___ \ \   o_/ |  | \/|   :  \ /  o \ |  . .  \\   o_/ 
	 \_____/ /______) \_____)|__|   |___:  /(______)|__: :  / \_____)
	       _____                         \/       .__     \/      
	      /     \    ____  _____  _______   ____  |  |__  ___.__.   
	     /   o   \  /    \ \__  \ \_  __ \_/ ___\ |  |  \(   :  |   
	    /    .    \|   .  \ /  o \ |  | \/\  \___ |   .  \\___  |   
	    \____:__  /|___:__/(______)|__|    \_____)|___:__//_____|   
	            \/                                                  
	Usage: ./username-anarchy [OPTIONS]... [firstname|first last|first middle last]
	Author: Andrew Horton (urbanadventurer). Version: 0.5

	Names:
	 -i, --input-file FILE     Input list of names. Can be SPACE, CSV or TAB delimited.
	                           Defaults to firstname, lastname. Valid column headings are:
	                           firstinitial, firstname, lastinitial, lastname,
	                           middleinitial, middlename.
	 -a, --auto                Automatically generate names from a country/list
	 -c, --country COUNTRY     COUNTRY can be one of the following datasets:
	                           PublicProfiler:
	                           argentina, austria, belgium, canada, china,
	                           denmark, france, germany, hungary, india, ireland,
	                           italy, luxembourg, netherlands, newzealand, norway,
	                           poland, serbia, slovenia, spain, sweden,
	                           switzerland, uk, us
	                           Other:
	                           Facebook - uses the Facebook top 10,000 names
	     --given-names FILE    Dictionary of given names
	     --family-names FILE   Dictionary of family names
	 -s, --substitute STATE    Control name substitutions
	                           Valid values are 'on' and 'off'. Default: off
	                           Can substitute any part of a name not available
	 -m, --max-sub NUM         Limit quantity of substitutions per plugin.
	                           Default: -1 (Unlimited)

	Username format:
	 -l, --list-formats        List format plugins
	 -f, --select-format LIST  Select format plugins by name. Comma delimited list
	 -r, --recognise USERNAME  Recognise which format is in use for a username.
	                           This uses the Facebook dataset. Use verbose mode to
	                           show progress.
	 -F, --format FORMAT       Define the user format using either format string or
	                           ABK format. See README.md for format details.

	Output:
	 -@, --suffix BOOL         Suffix. e.g. @example.com
	                           Default: None
	 -C BOOL,                  Case insensitive usernames.
	     --case-insensitive    Default: True (All lower case)

	Miscellaneous:
	 -v, --verbose             Display plugin format comments in output and displays
	                           last name searches in plugin format recogniser
	 -h, --help

```

Example Usage
-------------
### You know the name of a user but not the username format

	./username-anarchy anna key
	anna
	annakey
	anna.key
	annakey
	annak
	a.key
	akey
	kanna
	k.anna
	...


### You know the username format and names of users

	./username-anarchy --input-file ./test-names.txt  --select-format first.last
	andrew.horton
	jim.vongrippenvud
	peter.otoole


### You know the server is in France
Note that -a or --auto is required when you do not specify any input names.

	./username-anarchy --country france --auto
	martin
	bernard
	thomas
	durand
	richard
	robert
	petit
	moreau
	dubois
	simon
	martinsmith
	martinjohnson
	...

### List username format plugins

	./username-anarchy --list-formats
	Plugin name         	Example
	--------------------------------------------------------------------------------
	first               	anna
	firstlast           	annakey
	first.last          	anna.key
	firstlast[8]        	annakey
	firstl              	annak
	f.last              	a.key
	flast               	akey
	lfirst              	kanna
	l.first             	k.anna
	lastf               	keya
	last                	key
	last.f              	key.a
	last.first          	key.anna
	FLast               	AKey
	first1              	anna0,anna1,anna2
	fl                  	ak
	fmlast              	abkey
	firstmiddlelast     	annaboomkey
	fml                 	abk
	FL                  	AK
	FirstLast           	AnnaKey
	First.Last          	Anna.Key
	Last                	Key
	FML                 	ABK


### Automatically recognise the username format in use
	./username-anarchy --recognise j.smith
	Recognising j.smith. This can take a while.
	Username format j.smith recognised. Plugin name: f.last



Input Files
-----------
To generate usernames for more than one user account you must provide the names in a text file.
This can be either TAB or CSV delimited.

### Example 1
	Firstname,Lastname
	Andrew,Horton
	Jim, von Grippenvud
	Peter,O'Toole

### Example 2
LinkedIn often shows the firstname and last initial

	firstname,lastinitial
	andrew,h
	foo,b

### Example 3
Mixed set of names

	firstname,firstinitial,middleinitial,lastname,lastinitial
	andrew,,,horton,
	jim,,,,v
	,p,,o'toole,
	
Custom Plugins
--------------
### Command line Plugins
Define a custom plugin format using either the ABK or format string format.
Specify the username format with -F or --format

#### Example 1
	
	./username-anarchy -F "v-annakey" andrew horton
	v-andrewhorton

#### Example 2

	./username-anarchy -F "v-%f%l" -a -C poland
	v-nowaksmith
	v-nowakjohnson
	v-nowakjones
	v-nowakwilliams
	v-nowakbrown
	v-nowaklee
	v-nowakkhan
	v-nowaksingh
	v-nowakkumar
	v-nowakmiller
	...

### Writing Plugins
You can add plugins to username anarchy by defining them in format-plugins.rb

This example uses the ABK format.

	Plugin.define "last.first" do
		def generate(n)
			n.format_anna("key.anna")
		end
	end

This example uses the format string format.

	Plugin.define "first" do
		def generate(n)
			n.format("%f")
		end
	end


### Format Strings
Username Anarchy provides a method of defining a username format with format strings.

* %F - Firstname
* %M - Middlename
* %L - Lastname
* %f - firstname
* %m - middlename
* %l - lastname
* %i.f - first initial
* %i.m - middle initial
* %i.l - last initial
* %i.F - First initial
* %i.M - Middle initial
* %i.L - Last initial
* %D - Digit range 0..9
* %DD - Digit range 00..99


### ABK Format
Username Anarchy provides a method of defining a username format with ABK format which translates
to format strings.

* Anna - %F
* Boom - %M 
* Key - %L
* anna - %f
* boom - %m
* key - %l
* A - %i.F
* B - %i.M
* K - %i.L
* a - %i.f
* b - %i.m
* k - %i.l


Forum Usernames
---------------
The forum-names folder contains:
* common-forum-names.csv - A CSV file with forum names and the frequency they appeared with
* common-forum-names-top10k.txt - The top 10,000 forum names
* common-forum-names.txt - 1,774,313 forum names
* phpbb-scraper.rb - a web scraper for usernames on PHPbb forums



Name Resources
--------------

### Names
* http://worldnames.publicprofiler.org/SearchArea.aspx Some common countries. Top 10 surnames and forenames
* https://secure.wikimedia.org/wikipedia/en/wiki/List_of_most_popular_given_names
* http://www.babynamefacts.com/popularnames/countries.php?country=NZD top 100 baby names per country
* https://secure.wikimedia.org/wikipedia/en/wiki/List_of_most_common_surnames_in_Oceania

### Name Parsing:
* https://secure.wikimedia.org/wikipedia/en/wiki/Capitalization
* http://cpansearch.perl.org/src/KIMRYAN/Lingua-EN-NameParse-1.28/lib/Lingua/EN/NameParse.pm
* http://search.cpan.org/~summer/Lingua-EN-NameCase/NameCase.pm



