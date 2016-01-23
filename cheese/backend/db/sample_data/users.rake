namespace :db do
  namespace :sample_data do
    namespace :user do
      task :wipe do
        User.delete_all
      end
    end
    task :wipe => 'user:wipe'
  end
end
