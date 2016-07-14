module Capistrano
  module Itamae
    module Variables
      def itamae_path
        fetch(:itamae_path, "bundle exec itamae")
      end

      def itamae_default_options
        fetch(:itamae_default_options, [])
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

include Capistrano::Itamae::Variables
