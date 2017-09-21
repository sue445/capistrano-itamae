module Capistrano
  module Itamae
    module Variables
      def itamae_cookbooks_path
        Pathname.new(fetch(:itamae_cookbooks_path, "cookbooks"))
      end

      def itamae_bin_name
        fetch(:itamae_bin_name, "itamae")
      end

      def itamae_ssh_default_options
        fetch(:itamae_ssh_default_options)
      end

      def itamae_node_options
        fetch(:itamae_node_options)
      end

      def itamae_temp_node_file
        fetch(:itamae_temp_node_file, false)
      end

      def itamae_node_file
        Pathname.new(fetch(:itamae_node_file, "node.json"))
      end
    end
  end
end

include Capistrano::Itamae::Variables
