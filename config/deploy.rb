#SMELL - Need to get this working correctly.

server "catapult-apps.local", :app, :web, :db, :primary => true

set :application, "fat_free_crm"

set :deploy_to, "/Library/WebServer/Sites/#{application}"

set :user, "admin" # TODO use a 'deploy' user
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:catapult-elearning/fat_free_crm.git"

set :keep_releases, 3

set :bundle_without,  [:development, :test]


def symlink_config_file(name)
  run "ln -nfs #{shared_path}/config/#{name}.yml #{release_path}/config/#{name}.yml"
end

namespace :deploy do

  desc "Creates symbolic links from shared folder"
  task :setup_symlinks do
    %w{database}.each do |cfg_file|
      symlink_config_file(cfg_file)
    end
  end  
end

before 'deploy:restart', 'deploy:setup_symlinks'

after 'deploy', 'deploy:migrate'
after 'deploy', 'deploy:cleanup'
