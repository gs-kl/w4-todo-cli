class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
  end

  def run
    puts @projects = []
    puts "Welcome!"
    puts "'list' to list projects"
    puts "'create' to create a new project"
    puts "'edit' to edit a project"
    input = gets.chomp
    while input != "quit"
      if input == "create"
        puts "Please enter the new project name:"
        @projects << gets.chomp
      elsif input == "edit"
        puts "Please enter the project name to edit:"
        projecttoedit = gets.chomp
        puts "Please enter the new project name:"
        @projects[@projects.rindex(projecttoedit)] = gets.chomp
      elsif input == "list"
        puts "Projects:\n  #{display_projects}".chomp
      end
      input = gets.chomp
    end
  end

  def display_projects
    if @projects == []
      "none"
    else
      @projects.join
    end
  end

  def real_puts message=""
    $stdout.puts message
  end
end
