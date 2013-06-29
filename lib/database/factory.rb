module Database
  class Factory
    attr_reader :factory, :file_path
    YML_PATH = "#{Rails.root}/yml/"

    def self.create_records(factory_name, file_path)
      new(factory_name, file_path).create_records
    end

    def initialize(klass, file)
      @factory = klass
      @file_path = YML_PATH + file
    end

    def create_records
      record_hash = YAML.load(File.read(file_path))
      record_hash.each_value do |record|
        puts("#{factory}.create#{record}")
        factory.create(record)
      end
    end
  end
end
