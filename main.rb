require './app'

def main
  puts 'Welcome to school library app!'
  puts
  app = App.new
  app.welcome
  app.choose_action
end

main
