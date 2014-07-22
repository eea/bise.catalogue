object @site
attributes :id, :name
# attributes :target_list,
#            :action_list,
child(targets: :targets) { attributes :name }
child(actions: :actions) { attributes :name }
# child(:actions) { attributes :name }

