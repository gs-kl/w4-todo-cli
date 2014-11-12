class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
    @projects = []
  end

  class Project
    attr_accessor :name, :tasks
    def initialize name
      @name = name
      @tasks = []
    end
    def add_task name
      @tasks << name
    end
  end

  def print_text text
    puts text
  end

  def get_input
    gets.chomp
  end

  def run
    print_main_menu
    input = gets.chomp
    while input != "quit"
      if input == "create"
        create_project
      elsif input == "rename"
        rename_project
      elsif input == "list"
        list_projects
      elsif input == "edit"
        edit_project
      elsif input == "delete"
        delete_project
      end
      print_main_menu
      input = gets.chomp
    end
  end
  
  def delete_project
    print_text "Please enter the project name to delete:"
    project_to_delete = get_input
    @projects.delete(@projects.detect{|proj| proj.name == project_to_delete})
  end

  def rename_project
    puts "Please enter the project name to rename:"
    project_to_rename = get_input
    puts "Please enter the new project name:"
    new_name = get_input
    @projects.each do |proj|
      if proj.name == project_to_rename
        proj.name = new_name
      end
    end
  end

  def create_project
    puts "Please enter the new project name:"
    name = get_input
    @projects << Project.new(name)
  end

  def list_projects
    print_text "Projects:"
    if @projects.length == 0
      print_text "  none"
    else
      @projects.each {|a| print_text "  #{a.name}"}
    end
  end

  def edit_project
    puts "Please enter the name of the project to be edited:"
    project_to_edit = get_input
    project_object = @projects.detect {|proj| proj.name == project_to_edit}
    task_menu project_object
  end


  def task_menu project_object
    print_project_menu project_object.name
    input = gets.chomp
    while input != "back"
      if input == "list"
        puts "Tasks:"
        if project_object.tasks.length == 0
          puts "  none"
        else
          project_object.tasks.each do |a|
            puts "  #{a}"
          end
        end
      elsif input == "create"
        puts "Enter name of task to create:"
        to_add = gets.chomp
        project_object.add_task to_add
      elsif input == "rename"
        puts "Enter name of task to rename:"
        to_rename = gets.chomp
        if project_object.tasks.include? to_rename
          puts "Enter new name:"
          new_name = gets.chomp
          project_object.tasks[project_object.tasks.index(to_rename)] = new_name
        else
          puts "task not found: '#{to_rename}'"
        end
      elsif input == "complete"
        puts "Enter name of task to complete:"
        to_complete = gets.chomp
        if project_object.tasks.include? to_complete
          project_object.tasks[project_object.tasks.index(to_complete)] = "#{to_complete}: completed"
        else
          puts "task not found: '#{to_complete}'"
        end
      end

      input = gets.chomp
      print_project_menu project_object.name
    end
  end



  def print_project_menu project_to_edit
    puts "Editing Project: #{project_to_edit}"
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
