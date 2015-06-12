module SpreeAutogenerateVariants
  class Combinator
    def initialize(product)
      @product = product
    end

    def all
      @all ||= @product.option_types.map do |option_type|
        option_type.option_values.map(&:id)
      end.reduce do |combinations, combination|
        combinations.product(combination)
      end.map do |combination|
        combination.flatten.sort.join('-')
      end
    end

    def persisted
      @persisted ||= @product.variants.map do |variant|
        variant.option_values.map(&:id).sort.join('-')
      end
    end

    def not_persisted
      all - persisted
    end
  end
end
