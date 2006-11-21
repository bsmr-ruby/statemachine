require File.dirname(__FILE__) + '/../spec_helper'

context "The MainController" do
  controller_name :main

end

context "Index View spec" do
  controller_name :main
  integrate_views
  
  setup do
    @vm = VendingMachine.new
    @product = @vm.add_product(10, "Glue", 100)
    @vm.save!
    
    post :index, :id => @vm.id
  end

  specify "Has required divs" do
    response.should_have_tag :img, :attributes => { :id => "vending_machine_body" }
    response.should_have_tag :img, :attributes => { :id => "money_panel" }
    response.should_have_tag :a, :attributes => { :id => "cash_release_button" }
    response.should_have_tag :div, :attributes => { :id => "product_list" }
    response.should_have_tag :img, :attributes => { :id => "change" }
    response.should_have_tag :div, :attributes => { :id => "change_amount" }
    response.should_have_tag :div, :attributes => { :id => "cash" }
    response.should_have_tag :div, :attributes => { :id => "quartz_screen" }
    response.should_have_tag :div, :attributes => { :id => "dispenser" }
    response.should_have_tag :div, :attributes => { :id => "info" }
  end

  specify "products" do
    response.should_have_tag :a, :attributes => { :id => "product_#{@product.id}" }
    response.should_have_tag :span, :attributes => { :id => "product_#{@product.id}_price" }
  end
  
end