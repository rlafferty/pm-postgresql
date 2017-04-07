#
# Cookbook:: pm-postgresql
# Spec:: default
#
# Copyright:: 2017, PhishMe, All Rights Reserved.

require 'spec_helper'

describe 'pm-postgresql::client' do
  test_platforms = {
    'ubuntu' => {
      'versions' => ['14.04', '16.04']
    }
  }

  test_platforms.each do |platform, config|
    config['versions'].each do |version|
      context "running on: #{platform} #{version}" do
        let(:chef_run) do
          ChefSpec::ServerRunner.new(
            platform: platform,
            version: version
          ).converge(described_recipe)
        end

        it 'converges successfully' do
          expect { :chef_run }.to_not raise_error
        end

        it 'includes the client recipe' do
          expect(chef_run).to include_recipe('postgresql::client')
        end

        it 'includes the ruby recipe' do
          expect(chef_run).to include_recipe('postgresql::ruby')
        end

        it 'does not include the server recipe' do
          expect(chef_run).to_not include_recipe('postgresql::server')
        end
      end
    end
  end
end
