#
# Cookbook:: pm-postgresql
# Spec:: create_database
#
# Copyright:: 2017, PhishMe, All Rights Reserved.

require 'spec_helper'
require './libraries/matchers'

test_platforms = {
  'ubuntu' => {
    'versions' => ['14.04', '16.04']
  }
}

describe 'test::create_database' do
  test_platforms.each do |platform, config|
    config['versions'].each do |version|
      context "running on: #{platform} #{version}" do
        context "creates database if doesn't exist" do
          let(:chef_run) do
            ChefSpec::ServerRunner.new(
              platform: platform,
              version: version
            ) do |node|
              node.normal['postgresql']['password']['postgres'] = 'secret'
            end.converge(described_recipe)
          end

          before do
            allow_any_instance_of(Chef::Recipe).to receive(:already_exists?).and_return(false)
          end

          it 'converges successfully' do
            expect { :chef_run }.to_not raise_error
          end

          it 'creates database' do
            expect(chef_run).to create_pg_database('my_stuff')
          end
        end
      end
    end
  end
end
