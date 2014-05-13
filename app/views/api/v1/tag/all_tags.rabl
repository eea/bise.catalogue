collection @categories
attributes :id,
           :title,
child(:keywords) { attributes :name }