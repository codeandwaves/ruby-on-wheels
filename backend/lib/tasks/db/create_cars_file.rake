namespace :db do
  namespace :seed do
    desc 'Create json file with cars data from NHTSA API'
    task create_cars_file: :environment do
      EtlScript.go
    end
  end
end
