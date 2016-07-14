module Capistrano
  module Itamae
    module DSL
      def itamae_ssh(recipe_files, *options)
        recipe_files = Array(recipe_files) unless recipe_files.is_a?(Array)
        recipe_paths = recipe_files.map { |file| itamae_cookbooks_path.join(file) }

        itamae_options =
          if options.empty?
            itamae_default_options
          else
            options
          end

        run_locally do
          Bundler.with_clean_env do
            execute *generate_itamae_ssh_command(recipe_paths, itamae_options)
          end
        end
      end

      private

      def generate_itamae_ssh_command(recipe_paths, itamae_options)
        command = [:bundle, :exec, itamae_bin_name, :ssh]

        command += recipe_paths
        command += itamae_options unless itamae_options.empty?
        command += ssh_options

        command
      end
    end
  end
end

include Capistrano::Itamae::DSL
