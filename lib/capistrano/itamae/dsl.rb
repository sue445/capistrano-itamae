module Capistrano
  module Itamae
    module DSL
      def itamae_ssh(recipes, *options)
        recipes = Array(recipes) unless recipes.is_a?(Array)

        itamae_options = itamae_default_options if options.empty?

        command = []
        command << itamae_path
        command << "ssh"
        command += recipes
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
