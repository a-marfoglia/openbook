namespace :categories do
  desc "Add default categories to db"
  task :default_categories => :environment do
    if !Category.find_by(name: "Horror")
      Category.create(name: "Horror")
      Category.create(name: "Psicologico")
      Category.create(name: "Avventura")
      Category.create(name: "Azione")
    end
  end  

  desc "Run all tasks"
  task :load => :default_categories
end
