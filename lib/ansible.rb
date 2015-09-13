require 'zk'
require 'logger'
require 'open3'

include Process

################# SPACER

module Ansible

  ## Module constants
  ANSIBLE_WORKING_DIR="/users/kevinphillips/workspace/ansible-playbooks"

  ## Exceptions
  class PlaybookException < StandardError
  end

  # Thow progressively specific exceptions
  class FlattenParamsException < PlaybookException
  end

  ## Module meat, this will be used to scaffold different invocations
  class Playbook

    # initializer which forks ansible-playbook
    # Expects the following parameters:
    # - stage [to converge]
    # - playbook [to converge to]
    # It supports additional parameters as part of a hash (where arguments would be separated with a '-', use '_' instead
    # - limit
    # - extra_vars
    # - tags
    # - skip_tags
    def initialize(stage,playbook,*args)

      @inventory_file = stage_map[stage][:inventory_file]
      @playbook = playbook
      # Optional overrides or sane defaults
      @limit = args.include?(:limit) ? args[:limit] : "all"
      @extra_vars = args.include?(:extra_vars) ? args[:extra_vars] : { :run_by_aparatus => true }
      @tags = args.include?(:tags) ? args[:tags] : {}
      @skip_tags = args.include?(:skip_tags) ? args[:skip_tags] : {}

      puts "Spawning ansible-playbook ..."
      begin
        pid, status = waitpid2(ansible_spawn().pid)
        puts "PID: #{pid} has exited with exit status code: #{status.exitstatus}"
        puts "    The process outputed: #{@stdout.read}"
        puts "    The process errored: #{@stderr.read}"
        @stdout.close
        @stderr.close
        unless status.exited?
         puts "The process hasn't exited!"
         exit 2
        end
        return status.exitstatus
      rescue Errno::ECHILD
        puts "Failed to spawn ansible-playbook. Cannot continue."
        exit 1
      end

    end

    private
    # private object to map stages to inventory files
    def stage_map
      {
        'dev' => { :inventory_file => "devel_inventory" },
        'staging' => { :inventory_file => "inventory" },
        'production' => { :inventory_file => "inventory" }
      }
    end

    def construct_extra_arguments
      begin
        flattened_extra_vars = @extra_vars.map { |k,v| "#{k}=#{v}" }
        flattened_tags = @tags.map { |k,v| "#{k}=#{v}" }
        flattened_skip_tags = @skip_tags.map { |k,v| "#{k}=#{v}" }
        raise FlattenParamsException if flattened_extra_vars.nil? || flattened_tags.nil? || flattened_skip_tags.nil?
      rescue FlattenParamsException=>e
        puts "There was problem flattening additional parameters. Cannot continue. #{e.message}"
      end

      ## Attempt to form additional argument strings
      cmd_extra_vars = "-e " + flattened_extra_vars.join(" -e ")
      cmd_tags = " --tags=" + flattened_tags.join(",")
      cmd_skip_tags = " --skip-tags=" + flattened_skip_tags.join(",")

      ## Concat additional arguments unless they are empty
      extra_arguments = ""
      extra_arguments.concat(cmd_extra_vars) unless cmd_extra_vars == "-e "
      extra_arguments.concat(cmd_tags) unless cmd_tags == " --tags="
      extra_arguments.concat(cmd_skip_tags) unless cmd_skip_tags == " --skip-tags="
      return extra_arguments
    end

    # An ansible-playbook fork method
    def ansible_spawn
      additional_args = construct_extra_arguments()
      puts additional_args
      stdin, @stdout, @stderr, wait_thr = Open3.popen3("ansible-playbook", "--diff", "-i", @inventory_file, @playbook, "--limit=#{@limit}", additional_args, :chdir => ANSIBLE_WORKING_DIR)
      return wait_thr
    end

  end

end
