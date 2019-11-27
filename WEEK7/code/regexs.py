import re
"""regex practices"""

MyStr = 'an example'
match = re.search(r'\w*\s', MyStr) # match character that followed by space

if match:                      
    print('found a match:', match.group()) 
else:
    print('did not find a match')    

match = re.search(r'2', "it takes 2 to tango")# match '2'
match.group()

match = re.search(r'\d', "it takes 2 to tango")# match numeric character
match.group()

match = re.search(r'\d.*', "it takes 2 to tango")# match numeric character and whatever the following.
match.group()

match = re.search(r'\d.', "it takes 2 to tango")# match the numeris character and the one character following.
match.group()

match = re.search(r'\s\w{1,3}\s', "once upon a time") # match characters the in between two spaces and length is in between 1-3
match.group()


match = re.search(r'\s\w*$', "once upon a time")# find a space a character what ever in the middle and the end
match.group()


re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group() # find a bunch of characters followed by a space, a numeric cha, whatever thingsend up with a numeric cha

re.search(r'^\w*.*\s', 'once upon a time').group() # find the start, a bunch of character, what ever in between and a space.

re.search(r'<.+>', 'This is a <EM>first</EM> test').group() # find the characters or space in bewtwen <>

re.search(r'<.+?>', 'This is a <EM>first</EM> test').group() # find the character between <>, repeat only once(i.e. 2 characters/spaces)

re.search(r'\d*\.?\d*','1432.75+60.22i').group() # find the bunch of numbers with one/ zero "." in the middle and end with a number.

re.search(r'[AGTC]+', 'the sequence ATTCGT').group() # match any character listed(without space or number in between)

re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group() # find a space, a capital letter, a bunch of characters, 

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)# find any s[ace or characters,a comma, a space, any charracters+.+@
match.group()

MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr)
match.group()

match = re.search(r"[\w\s]?,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()


    # Try the regex we used above for finding names ([\w\s]+) for cases where the person's name has something unexpected, 
    # like a ? or a +. Does it work? 
    # How can you make it more robust?
    ###by including the potential symbols in the name to the regex, e.g. [\w\s\+\?\.]

    # Translate the following regular expressions into regular English:
    #     r'^abc[ab]+\s\t\d'
    ##    match the start of string, match exactly "abc", match "a" or "b" one or more times, a space, match a tab, match a integer

    #     r'^\d{1,2}\/\d{1,2}\/\d{4}$'
    ##    [match a date]match the start of string, match integers at least 1 but no more than 2 times, match a slash, match a integer 1 or 2 times, match a slash, ainteger 4 times, the end
    #     r'\s*[a-zA-Z,\s]+\s*'
    ##    match a space several times, any characters including upper lower space comma space multiple times, a space, the end.

    # Write a regex to match dates in format YYYYMMDD, making sure that:
    #     Only seemingly valid dates match (i.e., year greater than 1900)
    #     First digit in month is either 0 or 1
    #     First digit in day ≤3
 re.search(r'19|20\d{2}(0[1-9]|1[0-2])(0[1-9]|[1|2]\d|3[0-1])',"20090101").group()

####3 grouping regex patterns 
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()
match.group(0)
match = re.search(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)",MyStr)
if match:
    print(match.group(0))
    print(match.group(1))
    print(match.group(2))
    print(match.group(3))

####finding all matches

MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"
emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr) 
for email in emails:
    print(email)
# first use re.findall to match all the strings
# then use loop the print all the strings that you are looking for in the long string.
emails

#### finding files
f= open("../data/TestOaksData.csv",'r')

found_oaks = re.findall(r"Q[\w\s].*\s", f.read())
# read the file and match the words start with Q that followed by a character or space and any thing except new line break
# end up with a space.

found_oaks

#### group with multiple matches:
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a.academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a.academic@imperial.ac.uk, Some other stuff thats even more boring"

found_matches = re.findall(r'([\w\s]+),\s([\w\.-]+@[\w\.-]+)', MyStr)
found_matches
#### find all matches of: character or spaces, a comma, a space followed by characters or dot or dash more than onces
# , at symbol , characters or dot or dash more than onces from the string.

for item in found_matches:
    print(item)

#### exxtracting text from webpages:
import urllib3

conn =  urllib3.PoolManager()
r = conn.request('GET', 'https://www.imperial.ac.uk/silwood-park/academic-staff/') 
webpage_html = r.data 

type(webpage_html)

My_Data = webpage_html.decode()
print(My_Data)

pattern= r'Dr\s+\w+\s+\w+|Pro\w+\s+\w+\s+\w+'
regex = re.compile(pattern)
for match in regex.finditer(My_Data):
    print(match.group())
##### replace text
New_Data = re.sub(r'\t',' ',My_Data)


