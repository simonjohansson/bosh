# Copyright (c) 2009-2012 VMware, Inc.

module Bosh::Cli
  class DeploymentManifestCompiler
    attr_accessor :properties

    def initialize(raw_manifest)
      @raw_manifest = raw_manifest
      @properties = {}
    end

    def property(name)
      @properties[name] || raise(UndefinedProperty,
                                 "Cannot resolve deployment property `#{name}'")
    end

    def result
      erb_security_level = ENV['ERB_SECURITY_LEVEL'] ? ENV['ERB_SECURITY_LEVEL'].to_i : 4
      ERB.new(@raw_manifest, erb_security_level).result(binding.taint)
    rescue SyntaxError => e
      raise MalformedManifest,
            "Deployment manifest contains a syntax error\n" + e.to_s
    end
  end

end
