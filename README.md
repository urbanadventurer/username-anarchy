Username Anarchy
======================================

Version: 0.1 (November 2012)
Author: urbanadventurer

Description
------------
Tools for generating usernames when penetration testing.
Useful for user account/password brute force guessing and username enumeration. Usernames are half the password brute force problem.


Use cases
---------
You know the name of a user but not the username format

`./username-anarchy anna key
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
`

You know the username format and names of users

`./username-anarchy --select-format first.last --input-file ./test-names.txt 
andrew.horton
john.mccoll
blair.strang
jim.vongrippenvud
`

You know the server is in France

`./username-anarchy --country france --auto|moremartin
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
`

List username format plugins

`./username-anarchy --list-formats
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
`

Automatically recognise the username format in use
`./username-anarchy --recognise anna.key
Recognising anna.key. This can take a while.
`
	


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


