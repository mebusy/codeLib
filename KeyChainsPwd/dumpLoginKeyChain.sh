
# call dumpxxxx.sh  <passwd_to_check>


security dump-keychain -d login.keychain > keychain.txt

python keychain.py keychain.txt keychain.xls $1


