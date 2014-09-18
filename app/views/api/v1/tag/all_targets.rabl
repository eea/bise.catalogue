collection @targets
attributes :id,
           :title,

child(:ordered_actions, object_root: false) { attributes :title }
