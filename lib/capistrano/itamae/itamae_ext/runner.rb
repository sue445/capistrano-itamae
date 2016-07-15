module Capistrano
  module Itamae
    module ItamaeExt
      def run(*args)
        stdout_sync = $stdout.sync
        stderr_sync = $stderr.sync

        $stdout.sync = true
        $stderr.sync = true

        begin
          super
        ensure
          # restore sync
          $stdout.sync = stdout_sync
          $stderr.sync = stderr_sync
        end
      end
    end
  end
end

::Itamae::Runner.singleton_class.prepend(Capistrano::Itamae::ItamaeExt)
