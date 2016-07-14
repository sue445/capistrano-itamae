module Capistrano
  module Itamae
    module DSL
      require "bundler"

      def itamae_ssh(recipe_files, *options)
        recipe_files = Array(recipe_files) unless recipe_files.is_a?(Array)
        recipe_paths = recipe_files.map { |file| itamae_cookbooks_path.join(file) }

        itamae_options =
          if options.empty?
            itamae_ssh_default_options
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

      def ssh_options
        ssh_options = fetch(:ssh_options, {}).dup
        ssh_options.merge!(host.ssh_options) if host.ssh_options
        ssh_options[:user] ||= host.user
        ssh_options[:port] ||= host.port
        ssh_options[:keys] ||= host.keys
        ssh_options[:key]  ||= ssh_options[:keys].first if ssh_options[:keys] && !ssh_options[:keys].empty?

        options = []
        options << "--host #{host.hostname}"
        options << "--user #{ssh_options[:user]}" if ssh_options[:user]
        options << "--port #{ssh_options[:port]}" if ssh_options[:port]
        options << "--key #{ssh_options[:key]}" if ssh_options[:key]
        options
      end
    end
  end
end

include Capistrano::Itamae::DSL
