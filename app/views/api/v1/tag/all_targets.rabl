collection @targets
attributes :id,
           :title,
child(:strategy_actions, object_root: false) { attributes :title }