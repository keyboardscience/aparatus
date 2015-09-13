#!/usr/bin/env ruby

require 'spec_helper'

describe package('postgresql-9.4') do
  it { should be_installed }
end

## Configuration
describe file('/etc/postgresql') do
  it { should be_a_directory }
  it { should be_owned_by 'postgres' }
  it { should be_grouped_into 'postgres' } ## %postgres will be used to grant RO

  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }

  it { should be_writable.by('owner') }

  it { should_not be_readable.by('other') } ## access to postgresql configuration is privileged
  it { should_not be_writable.by('other') } ##   operators and admins need to escalate privilege to RW
end

describe file('/etc/postgresql/9.4/main') do
  it { should be_a_directory }
  it { should be_owned_by 'postgres' }
  it { should be_grouped_into 'postgres' }

  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }

  it { should be_writable.by('owner') }

  it { should_not be_readable.by('other') }
  it { should_not be_writable.by('other') }
end

describe file('/etc/postgresql/9.4/main/postgresql.conf') do
  it { should be_a_file }
  it { should be_owned_by 'postgres' }
  it { should be_grouped_into 'postgres' }

  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }

  it { should be_writable.by('owner') }

  it { should_not be_readable.by('other') }
  it { should_not be_writable.by('other') }
end

describe file('/etc/postgresql/9.4/main/pg_hba.conf') do
  it { should be_a_file }
  it { should be_owned_by 'postgres' }
  it { should be_grouped_into 'postgres' }

  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }

  it { should be_writable.by('owner') }

  it { should_not be_readable.by('other') }
  it { should_not be_writable.by('other') }
end

## Cluster
describe file('/var/lib/postgresql') do
  it { should be_a_directory }
  it { should be_owned_by 'postgres' }
  it { should be_grouped_into 'postgres' }

  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }

  it { should be_writable.by('owner') }

  it { should_not be_readable.by('other') }
  it { should_not be_writable.by('other') }
end

describe file('/var/lib/postgresql/9.4/main') do
  it { should be_a_directory }
  it { should be_owned_by 'postgres' }
  it { should be_grouped_into 'postgres' }

  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }

  it { should be_writable.by('owner') }

  it { should_not be_readable.by('other') }
  it { should_not be_writable.by('other') }
end

### Cluster socket, n.b. the main cluster should always run on 5432
describe file('/var/run/postgresql/.s.PGSQL.5432') do
  it { should be_a_socket }
  it { should be_owned_by 'postgres' }
  it { should be_grouped_into 'postgres' }

  it { should be_mode 777 }
end

describe file('/var/run/postgresql/9.4-main.pid') do
  it { should be_a_file }
  it { should be_owned_by 'postgres' }
  it { should be_grouped_into 'postgres' }

  it { should b_mode 644 }
end

## User
describe user('postgres') do
  it { should exist }
  it { should belong_to_group 'postgres' }
  it { should have_authorized_key POSTGRESQL_AUTHORIZED_KEY }
end

describe group('postgres') do
  it { should exist }
end

## Process
describe process('postgresql') do
  it { should be_running }
  its(:user) { should eq "postgres" }
  its(:args) { should match /config_file=\/etc\/postgresql\/9.4\/main\/postgresql.conf/ }
end

describe port(5432) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end

## Service
describe service('postgresql') do
  it { should be_enabled }
  it { should be_running.under('upstart') }
end
