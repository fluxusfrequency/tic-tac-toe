gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class CustomerTest < Minitest::Test
  attr_accessor :database, :customer

  def setup
    data = { :id => 1,
             :first_name => "Joey",
             :last_name => "Ondricka",
             :created_at => "2012-03-27 14:54:09 UTC",
             :updated_at => "2012-03-27 14:54:09 UTC"
             }

    @database = SalesEngine::Database
    database.startup_fixtures
    @customer ||= SalesEngine::Customer.new(data)
  end

  def test_it_should_exist
    assert !customer.nil?
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::Customer, customer.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, customer.id
    assert_equal "Joey", customer.first_name
    assert_equal "Ondricka", customer.last_name
    assert_equal Date.parse("2012-03-27 14:54:09 UTC"), customer.created_at
    assert_equal Date.parse("2012-03-27 14:54:09 UTC"), customer.updated_at
  end

  def test_the_invoices_method_returns_assocaiated_invoices
    assert_equal SalesEngine::Invoice, customer.invoices.first.class
    assert_equal customer.id, customer.invoices.first.customer_id.to_i
    assert_equal customer.id, customer.invoices.last.customer_id.to_i
  end

end