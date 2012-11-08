Username Anarchy
======================================

* Version: 0.1 (November 2012)
* Author: urbanadventurer

Description
------------
Tools for generating usernames when penetration testing.
Useful for user account/password brute force guessing and username enumeration. 
*Usernames are half the password brute force problem.*


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

	Usage: ./username-anarchy [OPTIONS]... [firstname|first last|first middle last]
	Version: 0.1

	NAMES
	--input-file, -i=FILE		Input list of names. Can be CSV or TAB delimited.
					Valid column headings are: firstinitial,firstname,
					lastinitial,lastname,middleinitial,middlename
	--auto, -a			Automatically generate names from a country or other lists.
	--country COUNTRY, -C		COUNTRY can be one of the following datasets:
					PublicProfiler:
					argentina, austria, belgium, canada, china, denmark, france, germany,
					hungary, india, ireland, italy, luxembourg, netherlands, newzealand,
					norway, poland, serbia, slovenia, spain, sweden, switzerland, uk, us
					Other:
					Facebook - uses the Facebook top 10,000 first and last names
	--given-names=FILE		Dictionary of given names
	--family-names=FILE		Dictionary of family names
	--substitute, -s=STATE		Control name substitutions.
					Valid values are 'on' and 'off'. Default: on
					Can substitute any part of a name not available.
	--max-substitutions, -m=NUM	Limit quantity of substitutions per plugin.
					Default: -1 (Unlimited)

	USERNAME FORMAT
	--list-formats, -l		List format plugins
	--select-format, -f=LIST	Select format plugins by name. Comma delimited list
	--recognise, -r=USERNAME	Recognise which format is in use for a username. This
					uses the Facebook dataset. Use verbose mode to show progress.

	MISC
	--verbose, -v			Display plugin format comments in output and displays last name searches
					in plugin format recogniser
	--help, -h			This help


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

	./username-anarchy --select-format first.last --input-file ./test-names.txt 
	andrew.horton
	john.mccoll
	blair.strang
	jim.vongrippenvud


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
	firstlast[8]        	AnnaKey
	firstl              	annak
	f.last              	a.key
	flast               	akey
	lfirst              	kanna
	l.first             	k.anna
	lastf               	keya
	last.f              	key.a
	last.first          	key.anna
	FLast               	AKey
	first1              	anna0,anna1,anna2
	fl                  	ak
	fmlast              	aakey,abkey,ackey
	firstmiddlelast     	annamichaelkey,annajohnkey,annadavidkey
	fml                 	aak,abk,ack
	canterbury-uni      	aak00,aak01,aak02
	FL                  	AK
	FML                 	AAK,ABK,ACK


### Automatically recognise the username format in use
	./username-anarchy --recognise anna.key
	Recognising anna.key. This can take a while.

	
Format String
--------------

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


ABK Format
-----------
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


