
# call dumpxxxx.sh  <passwd_to_check>


security dump-keychain -d login.keychain > keychain.txt

/usr/bin/python  keychain.py keychain.txt keychain.xls $1


