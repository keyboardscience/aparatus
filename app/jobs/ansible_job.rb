class AnsibleJob < ActiveJob::Base
  queue_as :ansible_create

  def perform(*args)
    ret = Ansible::Playbook.new('dev','create_cluster.yml', args)
    unless ret > 0
      exit 1
    else
      exit 0
    end
  end
end
