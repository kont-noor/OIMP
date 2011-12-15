# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{heroku}
  s.version = "2.8.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Heroku"]
  s.date = %q{2011-09-23 00:00:00.000000000Z}
  s.default_executable = %q{heroku}
  s.description = %q{Client library and command-line tool to deploy and manage apps on Heroku.}
  s.email = %q{support@heroku.com}
  s.executables = ["heroku"]
  s.files = ["README.md", "bin/heroku", "data/cacert.pem", "lib/heroku-postgresql/client.rb", "lib/heroku.rb", "lib/heroku/auth.rb", "lib/heroku/builtin_plugin.rb", "lib/heroku/client.rb", "lib/heroku/client/rendezvous.rb", "lib/heroku/command.rb", "lib/heroku/command/account.rb", "lib/heroku/command/addons.rb", "lib/heroku/command/apps.rb", "lib/heroku/command/auth.rb", "lib/heroku/command/base.rb", "lib/heroku/command/config.rb", "lib/heroku/command/db.rb", "lib/heroku/command/domains.rb", "lib/heroku/command/help.rb", "lib/heroku/command/keys.rb", "lib/heroku/command/logs.rb", "lib/heroku/command/maintenance.rb", "lib/heroku/command/pg.rb", "lib/heroku/command/pgbackups.rb", "lib/heroku/command/plugins.rb", "lib/heroku/command/ps.rb", "lib/heroku/command/releases.rb", "lib/heroku/command/run.rb", "lib/heroku/command/sharing.rb", "lib/heroku/command/ssl.rb", "lib/heroku/command/stack.rb", "lib/heroku/command/update.rb", "lib/heroku/command/version.rb", "lib/heroku/deprecated.rb", "lib/heroku/deprecated/help.rb", "lib/heroku/distribution.rb", "lib/heroku/helpers.rb", "lib/heroku/pg_resolver.rb", "lib/heroku/pgutils.rb", "lib/heroku/plugin.rb", "lib/heroku/updater.rb", "lib/heroku/version.rb", "lib/pgbackups/client.rb", "lib/vendor/heroku/okjson.rb", "spec/helper/legacy_help.rb", "spec/heroku/auth_spec.rb", "spec/heroku/client_spec.rb", "spec/heroku/command/addons_spec.rb", "spec/heroku/command/apps_spec.rb", "spec/heroku/command/auth_spec.rb", "spec/heroku/command/base_spec.rb", "spec/heroku/command/config_spec.rb", "spec/heroku/command/db_spec.rb", "spec/heroku/command/domains_spec.rb", "spec/heroku/command/help_spec.rb", "spec/heroku/command/keys_spec.rb", "spec/heroku/command/logs_spec.rb", "spec/heroku/command/maintenance_spec.rb", "spec/heroku/command/pg_spec.rb", "spec/heroku/command/pgbackups_spec.rb", "spec/heroku/command/plugins_spec.rb", "spec/heroku/command/ps_spec.rb", "spec/heroku/command/releases_spec.rb", "spec/heroku/command/run_spec.rb", "spec/heroku/command/sharing_spec.rb", "spec/heroku/command/ssl_spec.rb", "spec/heroku/command/stack_spec.rb", "spec/heroku/command/version_spec.rb", "spec/heroku/command_spec.rb", "spec/heroku/heroku-postgresql_client_spec.rb", "spec/heroku/pg_resolver_spec.rb", "spec/heroku/pgbackupsclient_spec.rb", "spec/heroku/plugin_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/support/display_message_matcher.rb"]
  s.homepage = %q{http://heroku.com/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Client library and CLI to deploy apps on Heroku.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<term-ansicolor>, ["~> 1.0.5"])
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.6.1"])
      s.add_runtime_dependency(%q<launchy>, [">= 0.3.2"])
      s.add_runtime_dependency(%q<rubyzip>, [">= 0"])
    else
      s.add_dependency(%q<term-ansicolor>, ["~> 1.0.5"])
      s.add_dependency(%q<rest-client>, ["~> 1.6.1"])
      s.add_dependency(%q<launchy>, [">= 0.3.2"])
      s.add_dependency(%q<rubyzip>, [">= 0"])
    end
  else
    s.add_dependency(%q<term-ansicolor>, ["~> 1.0.5"])
    s.add_dependency(%q<rest-client>, ["~> 1.6.1"])
    s.add_dependency(%q<launchy>, [">= 0.3.2"])
    s.add_dependency(%q<rubyzip>, [">= 0"])
  end
end
