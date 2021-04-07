module Menu
  def show_main_menu
    puts "\nWhat do you want ? Choose the number \n"
    puts "\n0. Exit"
    puts '1. Create the station'
    puts '2. Create the train'
    puts '3. Create/manage the route'
    puts '4. Set the route to the train'
    puts '5. Add the wagon to the train'
    puts '6. Delete the wagon from the train'
    puts '7. Move the train to forward or backward'
    puts '8. Show list of the station'
    puts '9. Show list of the train at the station'
    puts '10. Show list of the train wagon'
    puts "11. Take a place in the train\n"
  end

  def show_train_menu
    puts
    puts 'What do you want ? Choose the number'
    puts
    puts '1. Create the cargo train'
    puts '2. Create the passenger train'
    puts
  end

  def show_route_menu
    puts
    puts 'What do you want ? Choose the number'
    puts
    puts '1. Create the route'
    puts '2. Add the station to the route'
    puts '3. Delete the station from the route'
    puts
  end

  def show_move_train_menu
    puts
    puts 'What do you want ? Choose the number'
    puts
    puts '1. Move the train to the next station'
    puts '2. Move the train to the previous station'
    puts
  end
end
