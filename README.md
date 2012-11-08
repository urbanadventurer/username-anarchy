Username Anarchy
======================================

Version: 0.1 (November 2012)
Author: urbanadventurer

Description
------------

Tools for generating usernames when penetration testing.
Useful for user account/password brute force guessing and username enumeration.


Use cases
---------

You know the name of a user but not the username format
`$ ./username-anarchy anna key`

You know the username format and names of users
`$ ./username-anarchy --select-format first.last --input-file list-of-names.txt`

You know the server is in France
`$ ./username-anarchy --country france --auto`

List username format plugins
`$ ./username-anarchy --list-formats`

Automatically recognise the username format in use
`$ ./username-anarchy --recognise anna.key`
	

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



