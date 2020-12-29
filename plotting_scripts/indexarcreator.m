function output = indexarcreator(contactdata,day)

    index = (find([contactdata{:,3}] == day))';
    
    output = index;

end