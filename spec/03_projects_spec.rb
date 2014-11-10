require 'spec_helper'

describe TodoApp do
  # Don't mind all this crazy setup, testing command line apps is hard!
  let(:io_input)  { StringIO.new("") }
  let(:io_output) { StringIO.new("") }

  let(:app) { TodoApp.new(io_input, io_output) }
  let(:output) { io_output.string }

  describe 'working with projects' do
    describe "listing projects" do
      it "shows an empty list when there are no projects" do
        simulate_user_input("list", "quit")
        app.run

        expect(output).to include("Projects:\n  none")
      end
    end

    describe 'creating projects' do
      it "new projects will show up in the list" do
        simulate_user_input("create", "Chores", "list", "quit")
        app.run

        expect(output).to include("Please enter the new project name:\n")
        expect(output).to include("Projects:\n  Chores")
      end
    end

    describe 'editing projects' do
      it "existing projects can be renamed" do
        simulate_user_input("create", "Chores", "edit", "Chores", "Groceries", "list", "quit")
        app.run

        expect(output).to include("Please enter the project name to edit:\n")
        expect(output).to include("Please enter the new project name:\n")
        expect(output).to include("Projects:\n  Groceries")
      end
    end

   describe 'multiple projects' do
      it "can add and list multiple projects" do
        simulate_user_input("create", "Chores", "create", "Groceries", "list", "quit")
        app.run

        expect(output).to include("Projects:\n  Chores Groceries")
      end
      it "can edit one among several projects" do
        simulate_user_input("create", "Chores", "create", "Groceries", "edit", "Groceries", "Bookstore", "list", "quit")
        app.run

        expect(output).to include("Projects:\n  Chores Bookstore")
      end
    end

  
  end
end