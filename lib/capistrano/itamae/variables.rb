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
        fetch(:itamae_ssh_default_options, [])
      end
    end
  end
end

include Capistrano::Itamae::Variables
