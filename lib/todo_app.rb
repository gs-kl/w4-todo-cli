class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
  end

  class Project
    attr_accessor :name, :tasks
    def initialize name
      @name = name
      @tasks = []
    end
  end

  class Task
    def initialize name
      @name = name
      @completed = false
    end
  end

  def run
    puts @projects = []
    print_main_menu
    input = gets.chomp
    while input != "quit"
      if input == "create"
        puts "Please enter the new project name:"
        name = gets.chomp
        @projects << Project.new(name)
      elsif input == "rename"
        puts "Please enter the project name to rename:"
        project_to_rename = gets.chomp
        index = @projects.find_index do |proj|
          proj.name == project_to_rename
        end
        puts "Please enter the new project name:"
        new_name = gets.chomp
        @projects[index].name = new_name
      elsif input == "list"
        puts "Projects:\n  #{list_projects}".chomp
      elsif input == "edit"
        puts "Please enter the name of the project to be edited:"
        @project_to_edit = gets.chomp
        edit_project @project_to_edit
      elsif input == "delete"
        puts "Please enter the project name to delete:"
        proj_to_delete = gets.chomp
        index = @projects.find_index do |proj|
          proj.name == proj_to_delete
        end
        @projects.slice!(index)
      end
      print_main_menu
      input = gets.chomp
    end
  end

  def list_projects
    if @projects.length == 0
      "none"
    else
      output = ""
      @projects.each do |a|
        output << a.name
      end
      output
    end
  end

  def edit_project project_to_edit
    project_object_index = @projects.find_index do |a|
      a.name == @project_to_edit
    end
   
    project_object = @projects[project_object_index]

    print_project_menu
    input = gets.chomp
    while input != "back"
      if input == "list"
        puts "Tasks:"
        if project_object.tasks.length == 0
          puts "  none"
        end
      end
      input = gets.chomp
      print_project_menu
    end
  end

  def print_project_menu
    puts "Editing Project: #{@project_to_edit}"
    puts "'list' to list tasks"
    puts "'create' to create a new task"
    puts "'edit' to edit a task"
    puts "'complete' to complete a task and remove it from the list"
  end

  def print_main_menu
    puts "Welcome!"
    puts "'list' to list projects"
    puts "'create' to create a new project"
    puts "'edit' to edit a project"
    puts "'rename' to rename a project"
    puts "'delete' to delete a project"
    puts "'quit' to quit"
  end

  def real_puts message=""
    $stdout.puts message
  end
end
