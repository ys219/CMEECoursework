birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 
latin=[x[0] for x in birds]
print (latin)

common=[x[1] for x in birds]
print (common)

masses=[x[2] for x in birds]
print (masses)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
for i in range(3):
    lists=[x[i] for x in birds]
    print(lists)

