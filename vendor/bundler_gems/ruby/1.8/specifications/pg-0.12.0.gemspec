# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pg}
  s.version = "0.12.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Davis", "Michael Granger"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDLDCCAhSgAwIBAgIBADANBgkqhkiG9w0BAQUFADA8MQwwCgYDVQQDDANnZWQx\nFzAVBgoJkiaJk/IsZAEZFgdfYWVyaWVfMRMwEQYKCZImiZPyLGQBGRYDb3JnMB4X\nDTEwMDkxNjE0NDg1MVoXDTExMDkxNjE0NDg1MVowPDEMMAoGA1UEAwwDZ2VkMRcw\nFQYKCZImiZPyLGQBGRYHX2FlcmllXzETMBEGCgmSJomT8ixkARkWA29yZzCCASIw\nDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALy//BFxC1f/cPSnwtJBWoFiFrir\nh7RicI+joq/ocVXQqI4TDWPyF/8tqkvt+rD99X9qs2YeR8CU/YiIpLWrQOYST70J\nvDn7Uvhb2muFVqq6+vobeTkILBEO6pionWDG8jSbo3qKm1RjKJDwg9p4wNKhPuu8\nKGue/BFb67KflqyApPmPeb3Vdd9clspzqeFqp7cUBMEpFS6LWxy4Gk+qvFFJBJLB\nBUHE/LZVJMVzfpC5Uq+QmY7B+FH/QqNndn3tOHgsPadLTNimuB1sCuL1a4z3Pepd\nTeLBEFmEao5Dk3K/Q8o8vlbIB/jBDTUx6Djbgxw77909x6gI9doU4LD5XMcCAwEA\nAaM5MDcwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0OBBYEFJeoGkOr9l4B\n+saMkW/ZXT4UeSvVMA0GCSqGSIb3DQEBBQUAA4IBAQBG2KObvYI2eHyyBUJSJ3jN\nvEnU3d60znAXbrSd2qb3r1lY1EPDD3bcy0MggCfGdg3Xu54z21oqyIdk8uGtWBPL\nHIa9EgfFGSUEgvcIvaYqiN4jTUtidfEFw+Ltjs8AP9gWgSIYS6Gr38V0WGFFNzIH\naOD2wmu9oo/RffW4hS/8GuvfMzcw7CQ355wFR4KB/nyze+EsZ1Y5DerCAagMVuDQ\nU0BLmWDFzPGGWlPeQCrYHCr+AcJz+NRnaHCKLZdSKj/RHuTOt+gblRex8FAh8NeA\ncmlhXe46pZNJgWKbxZah85jIjx95hR8vOI+NAM5iH9kOqK13DrxacTKPhqj5PjwF\n-----END CERTIFICATE-----\n"]
  s.date = %q{2011-12-07}
  s.description = %q{Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/].

It works with PostgreSQL 8.2 and later.

This will be the last minor version to support 8.2 -- 0.13 will support 8.3 
and later, following the 
{PostgreSQL Release Support Policy}[http://bit.ly/6AfPhm].}
  s.email = ["ruby-pg@j-davis.com", "ged@FaerieMUD.org"]
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["Manifest.txt", "Contributors.rdoc", "History.rdoc", "README.ja.rdoc", "README.OS_X.rdoc", "README.rdoc", "README.windows.rdoc", "BSD", "GPL", "LICENSE", "ext/compat.c", "ext/pg.c"]
  s.files = [".gemtest", "BSD", "ChangeLog", "Contributors.rdoc", "GPL", "History.rdoc", "LICENSE", "Manifest.txt", "README.OS_X.rdoc", "README.ja.rdoc", "README.rdoc", "README.windows.rdoc", "Rakefile", "Rakefile.cross", "ext/compat.c", "ext/compat.h", "ext/extconf.rb", "ext/pg.c", "ext/pg.h", "ext/vc/pg.sln", "ext/vc/pg_18/pg.vcproj", "ext/vc/pg_19/pg_19.vcproj", "lib/pg.rb", "misc/openssl-pg-segfault.rb", "sample/async_api.rb", "sample/async_copyto.rb", "sample/copyfrom.rb", "sample/copyto.rb", "sample/cursor.rb", "sample/losample.rb", "sample/notify_wait.rb", "sample/psql.rb", "sample/psqlHelp.rb", "sample/test1.rb", "sample/test2.rb", "sample/test4.rb", "sample/test_binary_values.rb", "spec/data/expected_trace.out", "spec/data/random_binary_data", "spec/lib/helpers.rb", "spec/m17n_spec.rb", "spec/pgconn_spec.rb", "spec/pgresult_spec.rb"]
  s.homepage = %q{https://bitbucket.org/ged/ruby-pg}
  s.licenses = ["BSD", "Ruby", "GPL"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{pg}
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake-compiler>, ["~> 0.7"])
      s.add_development_dependency(%q<hoe-mercurial>, ["~> 1.3.1"])
      s.add_development_dependency(%q<hoe-highline>, ["~> 0.0.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6"])
      s.add_development_dependency(%q<hoe>, ["~> 2.12"])
    else
      s.add_dependency(%q<rake-compiler>, ["~> 0.7"])
      s.add_dependency(%q<hoe-mercurial>, ["~> 1.3.1"])
      s.add_dependency(%q<hoe-highline>, ["~> 0.0.1"])
      s.add_dependency(%q<rspec>, ["~> 2.6"])
      s.add_dependency(%q<hoe>, ["~> 2.12"])
    end
  else
    s.add_dependency(%q<rake-compiler>, ["~> 0.7"])
    s.add_dependency(%q<hoe-mercurial>, ["~> 1.3.1"])
    s.add_dependency(%q<hoe-highline>, ["~> 0.0.1"])
    s.add_dependency(%q<rspec>, ["~> 2.6"])
    s.add_dependency(%q<hoe>, ["~> 2.12"])
  end
end
