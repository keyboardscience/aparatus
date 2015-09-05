#!/usr/bin/env ruby

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require "ansible"

Ansible::Playbook.new('dev','playbook_kairos_servers.yml')
