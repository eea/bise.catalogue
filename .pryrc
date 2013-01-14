Pry.config.commands.import Pry::ExtendedCommands::Experimental

Pry.config.pager = false

Pry.config.color = true

Pry.config.commands.alias_command "lM", "ls -M"
Pry.config.commands.alias_command "ll", "ls -M"
Pry.config.commands.alias_command 'c', 'continue'
Pry.config.commands.alias_command 's', 'step'
Pry.config.commands.alias_command 'n', 'next'

Pry.config.commands.command "add", "Add a list of numbers together" do |*args|
  output.puts "Result is: #{args.map(&:to_i).inject(&:+)}"
end

Pry.config.history.should_save = false

Pry.config.prompt = [proc { "pry  > " },
                     proc { "     | " }]

# Disable pry-buggy-plug:
# Pry.plugins["buggy-plug"].disable!

