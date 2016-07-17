module Capistrano
  module Itamae
    module DSL
      # Run `itamae ssh`
      # @param recipe_files [String, Array<String>]
      # @param options [Hash<Symbol, String>] itamae ssh options (default is itamae_ssh_default_options)
      def itamae_ssh(recipe_files, options = {})
        recipe_files = Array(recipe_files) unless recipe_files.is_a?(Array)
        recipe_paths = recipe_files.map { |file| itamae_cookbooks_path.join(file) }

        itamae_options =
          if options.empty?
            itamae_ssh_default_options
          else
            options
          end

        ::Itamae::Runner.run(recipe_paths, :ssh, itamae_ssh_options(host, itamae_options))
      end

      private

      def itamae_ssh_options(server, itamae_options)
        options = ssh_options(server)
        options.merge!(itamae_options) unless itamae_options.empty?
        options
      end

      def ssh_options(server)
        ssh_options = fetch(:ssh_options, {}).dup
        ssh_options.merge!(server.ssh_options) if server.ssh_options
        ssh_options[:user] ||= server.user
        ssh_options[:port] ||= server.port
        ssh_options[:keys] ||= server.keys
        ssh_options[:key]  ||= ssh_options[:keys].first if ssh_options[:keys] && !ssh_options[:keys].empty?

        options = { host: server.hostname }
        options[:user] = ssh_options[:user] if ssh_options[:user]
        options[:port] = ssh_options[:port] if ssh_options[:port]
        options[:key]  = ssh_options[:key]  if ssh_options[:key]
        options
      end
    end
  end
end

include Capistrano::Itamae::DSL
