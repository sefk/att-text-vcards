#!/usr/bin/ruby
#
# == Synopsys
#   Dumb little program to spit out a vCard entries for AT&T's text gateways.  
#   Intention then is these can be imported into my address book and they can 
#   get a nice unique ringtone, for when I get a text sent this way.  VCF 
#   written to stdout.
#
#   Should be enhanced so all the constants can be overriden, but for now
#   they're still hardcoded into the script.
#
#   The range of phone numbers that AT&T uses for their outgoing text gateways
#   was just observed over a limited time.  I'd expect this to change.  Hence
#   this method and this script is pretty fragile.
#
#   Unfortunately I don't know of a VCF field to specify a custom text 
#   message tone, so that has to be done manually on the phone once the
#   contacts have replicated (bleh).
#
# == Usage
#   att-text-vcards > att-text.vcf
#   Then import att.txt.vcf into GMail Contacts or Outlook (only
#   tested with those two).  Tested that they make it through to 
#   my iPhone correctly.
#
# == Author
#   Sef Kloninger (sefklon@gmail.com)
#
# == Copyright
#   Copyright (c) 2011 Sef Kloninger. Licensed under the GPL (v2):
#   http://www.gnu.org/licenses/gpl-2.0.html
#

numBegin=0
numEnd=119
increment=8
phonyTypes=["TYPE=HOME","TYPE=WORK","TYPE=PAGER","TYPE=MOBILE","ASSISTANT",
            "TYPE=HOME;TYPE=FAX","TYPE=WORK;TYPE=FAX",
            "TYPE=COMPANY;TYPE=MAIN"]

if phonyTypes.length < increment
    print "error: won't have enough phone types\n"
    exit 1
end

counter=numBegin

while counter < numEnd
    if (counter + increment > numEnd)
        entries = numEnd - counter
    else
        entries = increment - 1
    end

    cardRange = sprintf("%03d-%03d", counter, counter+entries)

    printf "BEGIN:VCARD\n"
    printf "VERSION:3.0\n"
    printf "FN:\n"
    printf "N:;;;;\n"

    (0..entries).each do |i|
        printf("TEL;%s:1410000%03d\n", phonyTypes[i], counter+i)
    end

    printf "ORG:AT&T Texts %s\n", cardRange
    printf "END:VCARD\n"

    counter = counter + increment
end

