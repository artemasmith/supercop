module Supercop
  module Actions
    class Clean
      class << self
        def call
          if clean_gemfile[:changed]
            restore_gemfile

            update_bundle
          else
            notify_nothing_changed
          end

          remove_config
        end

        private

        def notify_nothing_changed
          puts 'Your Gemfile was not changed. Nothing to restore.'
        end

        def restore_gemfile
          puts 'Restoring your Gemfile'

          temp_file = "#{gemfile}.tmp"

          File.open(temp_file, 'w') do |f|
            f.print(clean_gemfile[:gemfile])
          end

          FileUtils.mv temp_file, gemfile
        end

        def update_bundle
          puts 'Updating your bundle, please wait'

          Bundler.with_clean_env do
            `bundle install`
          end
        end

        def clean_gemfile
          clean_gemfile = []
          changed = false

          File.open(gemfile, 'r') do |f|
            until (line = f.gets).nil?
              if line.include?(start_comment)
                changed = true
                until (line = f.gets).nil?
                  if line.include?(end_comment)
                    line = f.gets
                    break
                  end
                end
              end

              clean_gemfile << line
            end
          end
          @_clean_gemfile = { gemfile: clean_gemfile.join, changed: changed }
        end

        def remove_config
          if File.file?(supercop_config)
            puts 'Removing your supercop.yml'

            FileUtils.rm(supercop_config)
          end
        end

        def gemfile
          @_gemfile ||= File.join(Dir.pwd, 'Gemfile')
        end

        def supercop_config
          root = defined?(Rails) ? File.join(Dir.pwd, 'config') : Dir.pwd

          @_supercop_config ||= File.join(root, 'supercop.yml')
        end

        def start_comment
          Supercop::Actions::Loaders::Dependency::START_COMMENT
        end

        def end_comment
          Supercop::Actions::Loaders::Dependency::END_COMMENT
        end
      end
    end
  end
end
