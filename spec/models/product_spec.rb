require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is the first example' do
      @category = Category.create(name: 'Widgets')
      @product = Product.create(
        name: 'Flaming Widget', 
        description: 'Blah',
        category_id: @category.id,
        quantity: 1,
        image: nil,
        price: 8042
      )
      expect(@product.id).to be_present
    end
    it 'cannot have a blank name field' do
      @category = Category.create(name: 'Widgets')
      @product = Product.create(
        name: nil, 
        description: 'Blah',
        category_id: @category.id,
        quantity: 1,
        image: nil,
        price: 8042
      )
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'cannot have a blank price field' do
      @category = Category.create(name: 'Widgets')
      @product = Product.create(
        name: 'Flaming Widget', 
        description: 'Blah',
        category_id: @category.id,
        quantity: 1,
        image: nil,
        price: nil
      )
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'cannot have a blank quantity field' do
      @category = Category.create(name: 'Widgets')
      @product = Product.create(
        name: 'Flaming Widget', 
        description: 'Blah',
        category_id: @category.id,
        quantity: nil,
        image: nil,
        price: 8042
      )
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'cannot have a blank category field' do
      # @category = Category.create(name: 'Widgets')
      @product = Product.create(
        name: 'Flaming Widget', 
        description: 'Blah',
        category_id: nil,
        quantity: 1,
        image: nil,
        price: 7905
      )
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
