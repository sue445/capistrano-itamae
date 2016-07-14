module Capistrano
  module Itamae
    module DSL
      def itamae_ssh(recipe_files, *options)
        recipe_files = Array(recipe_files) unless recipe_files.is_a?(Array)
        recipe_paths = recipe_files.map { |file| itamae_cookbooks_path.join(file) }

        itamae_options = itamae_default_options if options.empty?

        command = []
        command << itamae_path
        command << "ssh"
        command += recipe_paths
        command += itamae_options unless itamae_options.empty?
        command += ssh_options

        run_locally do
          Bundler.with_clean_env do
            execute command.join(" ")
          end
        end
      end
    end
  end
end

include Capistrano::Itamae::DSL
