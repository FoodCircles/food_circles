require 'nested_form/builders'

module NestedForm
  module ViewHelper
    def nested_form_for(*args, &block)
      options = args.extract_options!.reverse_merge(:builder => NestedForm::Builder)
      form_for(*(args << options), &block) << after_nested_form_callbacks
    end

    if defined?(NestedForm::SimpleBuilder)
      def simple_nested_form_for(*args, &block)
        options = args.extract_options!.reverse_merge(:builder => NestedForm::SimpleBuilder)
        simple_form_for(*(args << options), &block) << after_nested_form_callbacks
      end
    end

    if defined?(NestedForm::FormtasticBuilder)
      def semantic_nested_form_for(*args, &block)
        options = args.extract_options!.reverse_merge(:builder => NestedForm::FormtasticBuilder)
        semantic_form_for(*(args << options), &block) << after_nested_form_callbacks
      end
    end

    def after_nested_form(blueprint_name, &block)
      @associations ||= []
      @after_nested_form_callbacks ||= []
      unless @associations.include?(blueprint_name)
        @associations << blueprint_name
        @after_nested_form_callbacks << block
      end
    end

    private
      def after_nested_form_callbacks
        @after_nested_form_callbacks ||= []
        fields = @after_nested_form_callbacks.map do |callback|
          callback.call
        end
        fields.join(" ").html_safe
      end
  end
end
