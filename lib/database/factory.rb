module Database
  class Factory
    attr_reader :klass, :path

    def self.create_records(factory, file_path)
      new(factory, file_path).create_records
    end

    def initialize(factory, file_path)
      @klass = factory.to_s.singularize.classify.constantize
      @path = file_path
    end

    def create_records
      record_hash = YAML.load(File.read(path))
      record_hash.each_value do |record|
        klass.create(record)
      end
    end
  end
end