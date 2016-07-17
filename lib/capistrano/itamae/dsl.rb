module Capistrano
  module Itamae
    module DSL
      require "bundler"

      # Run `itamae ssh`
      # @param recipe_files [String, Array<String>]
      # @param options [Array] itamae ssh options (default is itamae_ssh_default_options)
      def itamae_ssh(recipe_files, *options)
        recipe_paths = Array(recipe_files).map { |file| itamae_cookbooks_path.join(file) }

        itamae_options =
          if options.empty?
            itamae_ssh_default_options
          else
            options
          end

        # NOTE: store server (`host` is changed to localhost in `run_locally`)
        server = host

        run_locally do
          Bundler.with_clean_env do
            execute *generate_itamae_ssh_command(server, recipe_paths, itamae_options)
          end
        end
      end

      private

      def generate_itamae_ssh_command(server, recipe_paths, itamae_options)
        command = [:bundle, :exec, itamae_bin_name, :ssh]

        command += recipe_paths
        command += itamae_options unless itamae_options.empty?
        command += ssh_options(server)

        command
      end

      def ssh_options(server)
        ssh_options = fetch(:ssh_options, {}).dup
        ssh_options.merge!(server.ssh_options) if server.ssh_options
        ssh_options[:user] ||= server.user
        ssh_options[:port] ||= server.port
        ssh_options[:keys] ||= server.keys
        ssh_options[:key]  ||= ssh_options[:keys].first if ssh_options[:keys] && !ssh_options[:keys].empty?

        options = []
        options << "--host #{server.hostname}"
        options << "--user #{ssh_options[:user]}" if ssh_options[:user]
        options << "--port #{ssh_options[:port]}" if ssh_options[:port]
        options << "--key #{ssh_options[:key]}" if ssh_options[:key]
        options
      end
    end
  end
end

include Capistrano::Itamae::DSL
